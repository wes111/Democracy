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
            try await commentsManager.fetchReplies()
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
// Note: `LoadMore` nodes are inserted into the `commentsTree` to identify where
// more comments or replies can be fetched.
@MainActor @Observable
final class CommentsManager {
    var commentsTree: [CommentNode] = []
    
    @ObservationIgnored @Injected(\.commentService) private var commentService
    private let post: Post
    
    init(post: Post) {
        self.post = post
    }
}

// MARK: - Methods
extension CommentsManager {
    
    func fetchReplies(for parent: CommentNode? = nil) async throws {
        guard let nodeArray = nodeArray(for: parent) else {
            return
        }
        
        if let lastFetchedNode = nodeArray.dropLast().last {
            try await fetchAdditionalComments(for: parent, lastFetchedComment: lastFetchedNode)
        } else {
            try await fetchInitialComments(for: parent)
        }
    }
    
    func submitComment(text: String, parent: CommentNode?) async throws {
        let comment = try await commentService.submitComment(
            parentId: parent?.value.id,
            postId: post.id,
            content: text
        )
        
        // This node cannot have replies, bc it was just created.
        let node = CommentNode(value: comment, parent: parent)
        
        if let parent {
            if let replies = parent.replies {
                if let lastComment = replies.last, lastComment.isLoadMoreNode {
                    parent.children = updatedChildrenWithLoadMore(
                        replies: replies, newNode: node, lastNode: lastComment
                    )
                } else {
                    // NOTE: Appending directly to `children` breaks observation,
                    // so we need to assign an array to `parent.children`.
                    parent.children = updatedChildrenWithoutLoadMore(replies: replies, newNode: node)
                }
            } else {
                parent.children = [node]
            }
        } else {
            if let lastComment = commentsTree.last, lastComment.isLoadMoreNode {
                commentsTree = updatedChildrenWithLoadMore(
                    replies: commentsTree, newNode: node, lastNode: lastComment
                )
            } else {
                commentsTree.append(node)
            }
        }
    }
}

// MARK: - Private Methods
private extension CommentsManager {
    
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
    }
    
    func fetchAdditionalComments(for parent: CommentNode? = nil, lastFetchedComment: CommentNode) async throws {
        let request: CommentFetchRequest = if let parent {
            .childComments(parentId: parent.value.id, afterCommentId: lastFetchedComment.value.id)
        } else {
            .rootComments(postId: post.id, afterCommentId: lastFetchedComment.value.id)
        }
        let comments = try await commentService.fetchComments(request: request)
        
        if comments.isEmpty {
            removeLoadMoreNode(for: parent)
            return
        }
        updateCommentsTree(comments, parent: parent)
    }
    
    func nodeArray(for parent: CommentNode? = nil) -> [CommentNode]? {
        if let parent {
            parent.replies
        } else {
            commentsTree
        }
    }
    
    // Removing the `loadMore` node signifies that all replies have been fetched.
    func removeLoadMoreNode(for parent: CommentNode? = nil) {
        guard let nodeArray = nodeArray(for: parent), let lastNode = nodeArray.last, lastNode.isLoadMoreNode else {
            return
        }
        let updatedArray = Array(nodeArray.dropLast())
        
        if let parent {
            parent.children = updatedArray
        } else {
            commentsTree = updatedArray
        }
    }
    
    func updateCommentsTree(_ comments: [Comment], parent: CommentNode? = nil) {
        let nodeArray = comments.map { CommentNode(value: $0, parent: parent) }
        
        nodeArray.forEach { node in
            if node.value.responseCount > 0, node.children == nil {
                node.children = [CommentNode.loadMoreNode(parent: node)]
            }
        }
        
        if let parent {
            var updatedChildren: [CommentNode] = []
            if let replies = parent.replies {
                updatedChildren = Array(replies.dropLast())
            }
            updatedChildren.append(contentsOf: nodeArray)
            if comments.count == FetchLimit.comment.rawValue {
                updatedChildren.append(CommentNode.loadMoreNode(parent: parent))
            }
            
            parent.children = updatedChildren
        } else {
            var updatedRootComments: [CommentNode] = Array(commentsTree.dropLast())
            updatedRootComments.append(contentsOf: nodeArray)
            if comments.count == FetchLimit.comment.rawValue {
                updatedRootComments.append(CommentNode.loadMoreNode(parent: nil))
            }
            commentsTree = updatedRootComments
        }
    }
    
    func updatedChildrenWithLoadMore(replies: [CommentNode], newNode: CommentNode, lastNode: CommentNode) -> [CommentNode] {
        var updatedReplies = Array(replies.dropLast())
        updatedReplies.append(newNode)
        updatedReplies.append(lastNode)
        return updatedReplies
    }
    
    func updatedChildrenWithoutLoadMore(replies: [CommentNode], newNode: CommentNode) -> [CommentNode] {
        var updatedReplies = replies
        updatedReplies.append(newNode)
        return updatedReplies
    }
}
