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
            let commentVote = try await appwriteService.voteOnComment(.init(
                commentId: object.id,
                userId: try await userRepository.userId(),
                vote: vote
            ))
            return commentVote as! T.Vote
        } else {
            throw VoteRepositoryError.unhandledVotable
        }
    }
    
}
