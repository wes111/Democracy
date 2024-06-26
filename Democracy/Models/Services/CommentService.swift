//
//  CommentService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

enum CommentServiceError: Error {
    case reverseFailed
}

protocol CommentService: Sendable {
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment]
    func voteOnComment(_ comment: Comment, vote: VoteType) async throws -> CommentVote
}

final class CommentServiceDefault: CommentService {
    @Injected(\.commentRepository) private var commentRepository
    @Injected(\.userRepository) private var userRepository
    
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment {
        try await commentRepository.submitComment(.init(
            parentId: parentId,
            postId: postId,
            userId: try await userRepository.userId(),
            content: content
        ))
    }
    
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] {
        try await commentRepository.fetchComments(request: request)
    }
}

// MARK: - VoteOnComment
extension CommentServiceDefault {
    
    func voteOnComment(_ comment: Comment, vote: VoteType) async throws -> CommentVote {
        let originalVote = comment.userVote?.vote
        updateVoteCountsOnComment(comment, newVote: vote, originalVote: originalVote)
        updateUserVoteOnComment(comment, newVote: vote)
        
        do {
            let userVote = try await voteOnCommentInRepository(comment, vote: vote)
            comment.userVote = userVote
            return userVote
        } catch {
            updateVoteCountsOnComment(comment, newVote: vote, originalVote: originalVote, isReversal: true)
            try reverseUserVoteOnComment(comment, originalVote: originalVote)
            throw error
        }
    }
    
    private func updateVoteCountsOnComment(
        _ comment: Comment,
        newVote: VoteType,
        originalVote: VoteType?,
        isReversal: Bool = false
    ) {
        let increment: Int = !isReversal ? 1 : -1
        
        if let originalVote {
            if originalVote == newVote {
                switch originalVote { // Removing previous vote.
                case .up:
                    comment.upVoteCount -= increment
                case .down:
                    comment.downVoteCount -= increment
                }
            } else {
                switch newVote { // Switching vote.
                case .up:
                    comment.upVoteCount += increment
                    comment.downVoteCount -= increment
                case .down:
                    comment.downVoteCount += increment
                    comment.upVoteCount -= increment
                }
            }
        } else { // Adding a new vote.
            switch newVote {
            case .up:
                comment.upVoteCount += increment
            case .down:
                comment.downVoteCount += increment
            }
        }
    }
    
    private func voteOnCommentInRepository(_ comment: Comment, vote: VoteType) async throws -> CommentVote {
        try await commentRepository.voteOnComment(request: .init(
            commentId: comment.id,
            userId: try await userRepository.userId(),
            vote: vote
        ))
    }
    
    private func updateUserVoteOnComment(_ comment: Comment, newVote: VoteType) {
        if let userVote = comment.userVote {
            if userVote.vote == newVote {
                comment.userVote?.vote = nil
            } else {
                comment.userVote?.vote = newVote
            }
        } else {
            comment.userVote = .init(id: "temp", creationDate: .now, commentId: comment.id, userId: "", vote: newVote)
        }
    }
    
    private func reverseUserVoteOnComment(_ comment: Comment, originalVote: VoteType?) throws {
        guard let userVote = comment.userVote else {
            throw CommentServiceError.reverseFailed
        }
        
        if userVote.id == "temp" {
            comment.userVote = nil
        } else {
            comment.userVote?.vote = originalVote
        }
    }
}
