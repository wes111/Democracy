//
//  VoteRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/29/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

enum VoteRepositoryError: Error {
    case unhandledVotable
}

protocol VoteRepository {
    func voteOnObject<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote
}

final class VoteRepositoryDefault: VoteRepository {
    @Injected(\.appwriteService) private var appwriteService
    @Injected(\.userRepository) private var userRepository
    
    func voteOnObject<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote {
        if let object = object as? Comment {
            return try await voteOnComment(object, vote: vote) as! T.Vote
            
        } else if let object = object as? Post {
            return try await voteOnPost(object, vote: vote) as! T.Vote
            
        } else {
            throw VoteRepositoryError.unhandledVotable
        }
    }
}

// MARK: - Private Methods
private extension VoteRepositoryDefault {
    
    func voteOnComment(_ comment: Comment, vote: VoteType) async throws -> CommentVote {
        try await appwriteService.voteOnComment(.init(
            commentId: comment.id,
            userId: try await userRepository.userId(),
            vote: vote
        ))
    }
    
    func voteOnPost(_ post: Post, vote: VoteType) async throws -> PostVote {
        try await appwriteService.voteOnPost(.init(
            postId: post.id,
            userId: try await userRepository.userId(),
            vote: vote
        ))
    }
}
