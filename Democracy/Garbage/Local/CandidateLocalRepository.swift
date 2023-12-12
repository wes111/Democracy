//
//  CandidateLocalRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation

protocol CandidateLocalRepositoryProtocol {
    func getCandidates() async throws -> [Candidate]
    func addCandidate(_ candidate: Candidate) async throws
    func upVoteCandidate(_ candidate: Candidate) async throws
    func downVoteCandidate(_ candidate: Candidate) async throws
    func getCandidate(id: String) async throws -> Candidate?
}

enum CandidateLocalRepositoryError: Error {
    case unexpected
    case noDatabase
}

class CandidateLocalRepository: CandidateLocalRepositoryProtocol {
    
    init() { }
    
    func getCandidates() async throws -> [Candidate] {
    []
//        return try await databaseService.getDatabaseConnection().read { db in
//            try Candidate.fetchAll(db)
//        }
    }
    
    func addCandidate(_ candidate: Candidate) async throws {
        
//        try await databaseService.getDatabaseConnection().write { db in
//            try candidate.insert(db)
//        }
    }
    
    private func deleteAllCandidates() async throws {
        
//        try await databaseService.getDatabaseConnection().write { db in
//            _ = try Candidate.deleteAll(db)
//        }
    }
    
    func upVoteCandidate(_ candidate: Candidate) async throws {

//        try await databaseService.getDatabaseConnection().write { db in
//            var upvotedCandidate = candidate
//            upvotedCandidate.upVotes += 1
//            try upvotedCandidate.save(db)
//        }
    }
    
    func downVoteCandidate(_ candidate: Candidate) async throws {
        
//        try await databaseService.getDatabaseConnection().write { db in
//            var downVotedCandidate = candidate
//            downVotedCandidate.downVotes -= 1
//            try downVotedCandidate.save(db)
//        }
    }
    
    func getCandidate(id: String) async throws -> Candidate? {
        // try await getCandidates().first(where: { $0.id == id })
        return nil
    }
    
}
