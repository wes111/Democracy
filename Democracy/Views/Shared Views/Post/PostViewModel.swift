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
    
    func fetchInitialComments() async {
        do {
            try await commentsManager.fetchInitialComments()
        } catch {
            alertModel = PostAlert.fetchInitialCommentsFailed.toNewAlertModel()
        }
    }
    
    func loadButtonText(for node: CommentNode?) -> String {
        if let node {
            if let replies = node.replies, replies.count > 1 {
                "Load More Replies"
            } else {
                "Load Replies"
            }
        } else {
            if comments.count > 1 {
                "Load More Comments"
            } else {
                "Load Comments"
            }
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
    
    func onTapLoadReplies(comment: CommentNode?) async {
        do {
            try await commentsManager.fetchReplies(for: comment)
        } catch {
            print(error) // TODO: Show alert?
        }
    }
}

// MARK: - CommentsManager
@MainActor @Observable
final class CommentsManager {
    var commentsTree: [CommentNode] = [CommentNode.loadMoreNode(parent: nil)]
    
    @ObservationIgnored @Injected(\.commentService) private var commentService
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
    
    func submitComment(text: String, parent: CommentNode?) async throws {
//        let comment = try await commentService.submitComment(
//            parentId: parent?.value.id,
//            postId: post.id,
//            content: text
//        )
//        
//        let node = CommentNode(value: comment)
//        
//        if let parent {
//            if parent.hasLoadedAllReplies {
//                node.isEnd = true
//            }
//            
//            if let children = parent.children {
//                // NOTE: Appending directly to `children` breaks observation,
//                // so we need to assign an array to `parent.children`.
//                var newChildren = children
//                newChildren.append(node)
//                
//                parent.children = newChildren
//            } else {
//                parent.children = [node]
//            }
//        } else {
//            commentsTree.append(node)
//        }
    }
    
    private func nodeArray(for parent: CommentNode? = nil) -> [CommentNode]? {
        if let parent {
            parent.replies
        } else {
            commentsTree
        }
    }
    
    func fetchReplies(for parent: CommentNode? = nil) async throws {
        guard let nodeArray = nodeArray(for: parent), let lastNode = nodeArray.last, lastNode.isLoadMoreNode else {
            return // If the last node is not the `loadMoreNode`, all comments have been fetched.
        }
        
        if nodeArray.count == 1 {
            try await fetchInitialComments(for: parent)
        } else {
            guard let lastFetchedNode = nodeArray.dropLast().last else {
                return // FATAL ERROR
            }
            try await fetchAdditionalComments(for: parent, lastFetchedComment: lastFetchedNode)
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
    
    private func fetchAdditionalComments(for parent: CommentNode? = nil, lastFetchedComment: CommentNode) async throws {
        let request: CommentFetchRequest = if let parent {
            .childComments(parentId: parent.value.id, afterCommentId: lastFetchedComment.value.id)
        } else {
            .rootComments(postId: post.id, afterCommentId: lastFetchedComment.value.id)
        }
        let comments = try await commentService.fetchComments(request: request)
        
        if comments.isEmpty {
            removeEndNode(for: parent)
            return
        }
        updateCommentsTree(comments, parent: parent)
    }
    
    // Removing the end node signifies that all replies have been fetched.
    private func removeEndNode(for parent: CommentNode? = nil) {
        guard let nodeArray = nodeArray(for: parent), let lastNode = nodeArray.last, lastNode.isLoadMoreNode else {
            print("FATAL ERROR")
            return
        }
        let updatedArray = Array(nodeArray.dropLast())
        
        if let parent {
            parent.children = updatedArray
        } else {
            commentsTree = updatedArray
        }
    }
    
    private func updateCommentsTree(_ comments: [Comment], parent: CommentNode? = nil) {
        var nodeArray = comments.map { CommentNode(value: $0, parent: parent) }
        
        nodeArray.forEach { node in
            if node.value.responseCount > 0, node.children == nil {
                node.children = [CommentNode.loadMoreNode(parent: node)] // This is causing issues... hmm....
            }
        }
        
        if let parent {
            var newArray: [CommentNode] = []
            if let replies = parent.replies {
                newArray = Array(replies.dropLast())
            }
            newArray.append(contentsOf: nodeArray)
            if comments.count == FetchLimit.comment.rawValue {
                newArray.append(CommentNode.loadMoreNode(parent: parent))
            }
            
            parent.children = newArray
        } else {
            var newArray: [CommentNode] = Array(commentsTree.dropLast())
            newArray.append(contentsOf: nodeArray)
            if comments.count == FetchLimit.comment.rawValue {
                newArray.append(CommentNode.loadMoreNode(parent: nil))
            }
            commentsTree = newArray
        }
    }
}
