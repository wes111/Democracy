//
//  CommentViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/26/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

@MainActor
protocol CommentViewModelDelegate: AnyObject {
    func onTapCommentReply(comment: CommentNode)
}

@MainActor @Observable
final class CommentViewModel {
    let commentNode: CommentNode
    private var currentVote: VoteType?
    
    @ObservationIgnored @Injected(\.commentService) private var commentService
    @ObservationIgnored weak var delegate: CommentViewModelDelegate?
    
    init(comment: CommentNode, delegate: CommentViewModelDelegate?) {
        self.commentNode = comment
        self.delegate = delegate
    }
}

// MARK: - Methods
extension CommentViewModel {
    
    // TODO: Need to persist locally upvotes/downvotes....
    // Leaving this comment here, because the postViewModel should have a dictionary of
    // up/down votes for all comments...
    // Current vote will be fetched from local storage on init.
    func didTapVoteButton(_ vote: VoteType) {
        Task {
            do {
                try await commentService.voteOnComment(comment, vote: vote)
            } catch {
                print(error)
                print()
            }
        }
    }
    
    func didTapMenuButton() {
        
    }
    
    func didTapReplyButton() {
        delegate?.onTapCommentReply(comment: commentNode)
    }
}

// MARK: - Comupted Properties
extension CommentViewModel {
    
    var comment: Comment {
        commentNode.value
    }
    
    var content: String {
        comment.content
    }
    
    var username: String {
        comment.userId
    }
    
    var userTagline: String {
        "New York City"
    }
    
    var loadRepliesTitle: String {
        "Load \(commentNode.value.responseCount)+ Replies"
    }
    
    var date: String {
        comment.creationDate.getFormattedDate(format: .ddMMMyyyy)
    }
    
    var upVoteCount: Int {
        comment.upVoteCount
    }
    
    var downVoteCount: Int {
        comment.downVoteCount
    }
}
