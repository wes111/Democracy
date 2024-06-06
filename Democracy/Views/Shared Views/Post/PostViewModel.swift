//
//  PostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation
import Factory

enum PostAlert: AlertModelProtocol {
    case submitCommentFailed
    case fetchInitialCommentsFailed
    
    var title: String {
        switch self {
        case .submitCommentFailed:
            "Submit Comment Failed"
        case .fetchInitialCommentsFailed:
            "Fetch Initial Comments Failed"
        }
    }
    
    var description: String {
        switch self {
        case .submitCommentFailed, .fetchInitialCommentsFailed:
            "Please try again later."
        }
    }
}

protocol PostCoordinatorDelegate: AnyObject {
    func goBack()
}

@MainActor @Observable
final class PostViewModel {

    var isFocused: Bool = false
    var isLoading: Bool = false
    var alertModel: NewAlertModel?
    var replyingToComment: CommentNode?
    var commentText: String = ""
    
    private weak var coordinator: PostCoordinatorDelegate?
    private let post: Post
    private let commentsManager: CommentsManager
    
    init(coordinator: PostCoordinatorDelegate?, post: Post) {
        self.coordinator = coordinator
        self.post = post
        commentsManager = CommentsManager(post: post)
    }
}

// MARK: - Computed Properties
extension PostViewModel {
    
    var leadingContent: [TopBarContent] {
        [.back(goBack)]
    }
    
    var centerContent: [TopBarContent] {
        [.title("Todo - Title")]
    }
    
    var trailingContent: [TopBarContent] {
        [.menu([])]
    }
    
    var replyText: String {
        if let replyingToComment {
            "Replying to \(replyingToComment.value.userId)"
        } else {
            "Adding a top-level comment"
        }
    }
    
    var comments: [CommentNode] {
        commentsManager.commentsTree
    }
}

// MARK: - Methods
extension PostViewModel {
    
    func cancelAddingComment() {
        isFocused = false
        replyingToComment = nil
    }
    
    func submitComment() async {
        guard !commentText.isEmpty else {
            return
        }
        isFocused = false
        
        do {
            try await commentsManager.submitComment(text: commentText, parent: replyingToComment)
            commentText = ""
            replyingToComment = nil
        } catch {
            alertModel = PostAlert.submitCommentFailed.toNewAlertModel()
        }
    }
    
    func fetchInitialPosts() async {
        do {
            try await commentsManager.fetchInitialComments()
        } catch {
            alertModel = PostAlert.fetchInitialCommentsFailed.toNewAlertModel()
        }
    }
}

private extension PostViewModel {
    
    func goBack() {
        coordinator?.goBack()
    }
}

// MARK: - Protocol Conformance
extension PostViewModel: CommentViewModelDelegate {
    
    func onTapCommentReply(comment: CommentNode) {
        replyingToComment = comment
    }
    
    func onTapLoadReplies(comment: CommentNode) async {
        do {
            try await commentsManager.fetchInitialComments(for: comment)
        } catch {
            print(error) // TODO: Show alert?
        }
    }
}

// MARK: - CommentsManager
@MainActor @Observable
final class CommentsManager {
    var commentsTree: [CommentNode] = []
    
    @ObservationIgnored @Injected(\.commentService) private var commentService
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func submitComment(text: String, parent: CommentNode?) async throws {
        let comment = try await commentService.submitComment(
            parentId: parent?.value.id,
            postId: post.id,
            content: text
        )
        
        let node = CommentNode(value: comment)
        
        if let parent {
            if var children = parent.children {
                children.append(node)
            } else {
                parent.children = [node]
            }
        } else {
            commentsTree.append(node)
        }
        
        if let parent, parent.hasLoadedAllReplies {
            node.isEnd = true
        }
    }
    
    // For root comments, the `parent` is nil.
    // Call this method once for root comments and no more than once per node.
    func fetchInitialComments(for parent: CommentNode? = nil) async throws {
        let request: CommentFetchRequest = if let parent {
            .initialChildComments(parentId: parent.value.id)
        } else {
            .initialRootComments(postId: post.id)
        }
        let comments = try await commentService.fetchComments(request: request)
        updateCommentsTree(comments, parent: parent)
        // We do not need to check if the initial comments are empty.
        // If the post has no root comments, there is no action to take.
        // If a node has no children comments, we do not call this method, and so comments will not be empty.
    }
    
    // If called before `fetchInitialComments`, the method returns with no action.
    func fetchAdditionalComments(for parent: CommentNode? = nil) async throws {
        let lastFetchedComment = parent == nil ? commentsTree.last : parent?.children?.last
        
        guard let lastFetchedComment, !lastFetchedComment.isEnd else {
            return // All comments have already been fetched.
        }
        let request: CommentFetchRequest = if let parent {
            .childComments(parentId: parent.value.id, afterCommentId: lastFetchedComment.value.id)
        } else {
            .rootComments(postId: post.id, afterCommentId: lastFetchedComment.value.id)
        }
        let comments = try await commentService.fetchComments(request: request)
        
        guard !comments.isEmpty else {
            lastFetchedComment.isEnd = true
            return
        }
        updateCommentsTree(comments, parent: parent)
    }
    
    private func updateCommentsTree(_ comments: [Comment], parent: CommentNode? = nil) {
        let nodeArray = comments.map { CommentNode(value: $0) }
        
        if let parent {
            if var children = parent.children {
                children.append(contentsOf: nodeArray)
            } else {
                parent.children = nodeArray
            }
        } else {
            commentsTree.append(contentsOf: nodeArray)
        }
        
        if comments.count != FetchLimit.comment.rawValue {
            nodeArray.last?.isEnd = true
        }
    }
}
