//
//  VoteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/29/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

// An object that can be voted on, e.g. a `Comment` or a `Post`.
protocol Votable: AnyObject {
    associatedtype Vote: VoteProtocol
    
    var id: String { get }
    var userVote: Vote? { get set }
    var upVoteCount: Int { get set }
    var downVoteCount: Int { get set }
}

// A vote on a `Votable` object.
protocol VoteProtocol {
    var id: String { get }
    var creationDate: Date { get }
    var itemId: String { get } // The id of the `Votable` object.
    var userId: String { get }
    var vote: VoteType? { get set }
    
    static func createTempVote() -> Self
}

enum VoteServiceError: Error {
    case unhandledVotable
    case reverseFailed
}

protocol VoteService {
    @discardableResult
    func voteOnObject<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote
}

final class VoteServiceDefault: VoteService {
    @Injected(\.userRepository) private var userRepository
    @Injected(\.voteRepository) private var voteRepository
    
    func voteOnObject<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote {
        let originalVote = object.userVote?.vote
        updateVoteCountsOnObject(object, newVote: vote, originalVote: originalVote)
        updateUserVoteOnObject(object, newVote: vote)
        
        do {
            let userVote = try await voteOnObjectInRepository(object, vote: vote)
            object.userVote = userVote
            return userVote
        } catch {
            updateVoteCountsOnObject(object, newVote: vote, originalVote: originalVote, isReversal: true)
            try reverseUserVoteOnObject(object, originalVote: originalVote)
            throw error
        }
    }
}

// MARK: - Private Methods
private extension VoteServiceDefault {
    
    func updateVoteCountsOnObject<T: Votable>(
        _ object: T,
        newVote: VoteType,
        originalVote: VoteType?,
        isReversal: Bool = false
    ) {
        let increment: Int = !isReversal ? 1 : -1
        
        if let originalVote {
            if originalVote == newVote {
                switch originalVote { // Removing previous vote.
                case .up:
                    object.upVoteCount -= increment
                case .down:
                    object.downVoteCount -= increment
                }
            } else {
                switch newVote { // Switching vote.
                case .up:
                    object.upVoteCount += increment
                    object.downVoteCount -= increment
                case .down:
                    object.downVoteCount += increment
                    object.upVoteCount -= increment
                }
            }
        } else { // Adding a new vote.
            switch newVote {
            case .up:
                object.upVoteCount += increment
            case .down:
                object.downVoteCount += increment
            }
        }
    }
    
    func voteOnObjectInRepository<T: Votable>(_ object: T, vote: VoteType) async throws -> T.Vote {
        if let object = object as? Comment {
            return try await voteRepository.voteOnObject(object, vote: vote) as! T.Vote
        } else {
            throw VoteServiceError.unhandledVotable
        }
    }
    
    func updateUserVoteOnObject<T: Votable>(_ object: T, newVote: VoteType) {
        if let userVote = object.userVote {
            if userVote.vote == newVote {
                object.userVote?.vote = nil
            } else {
                object.userVote?.vote = newVote
            }
        } else {
            object.userVote = T.Vote.createTempVote()
        }
    }
    
    func reverseUserVoteOnObject<T: Votable>(_ object: T, originalVote: VoteType?) throws {
        guard let userVote = object.userVote else {
            throw VoteServiceError.reverseFailed
        }
        
        if userVote.id == "temp" {
            object.userVote = nil
        } else {
            object.userVote?.vote = originalVote
        }
    }
}
