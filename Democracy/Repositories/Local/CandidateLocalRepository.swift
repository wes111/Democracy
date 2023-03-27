//
//  CandidateLocalRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation
import GRDB

protocol CandidateLocalRepositoryProtocol {
    func getCandidates() async throws -> [Candidate]
    func addCandidate(_ candidate: Candidate) async throws
    func deleteAllCandidates() async throws
    func upvoteCandidate(_ candidate: Candidate) async throws
    func getCandidate(id: UUID) async throws -> Candidate?
}

enum CandidateLocalRepositoryError: Error {
    case unexpected
    case noDatabase
}

class CandidateLocalRepository: CandidateLocalRepositoryProtocol {
    
    @Injected(\.grdbService) var grdbService
    private var db: DatabaseQueue?
    
    init() {
        self.db = grdbService.database
    }
    
    private func createTable() {
        
    }
    
    func getCandidates() async throws -> [Candidate] {
        guard let db = db else {
            throw CandidateLocalRepositoryError.noDatabase
        }
        return try await db.read { db in
            try Candidate.fetchAll(db)
        }
    }
    
    func addCandidate(_ candidate: Candidate) async throws {
        guard let db = db else {
            throw CandidateLocalRepositoryError.noDatabase
        }
        
        try await db.write { db in
            try candidate.insert(db)
        }
    }
    
    func deleteAllCandidates() async throws {
        guard let db = db else {
            throw CandidateLocalRepositoryError.noDatabase
        }
        try await db.write { db in
            _ = try Candidate.deleteAll(db)
        }
    }
    
    func upvoteCandidate(_ candidate: Candidate) async throws {
        guard let db = db else {
            throw CandidateLocalRepositoryError.unexpected
        }
        try await db.write { db in
            var upvotedCandidate = candidate
            upvotedCandidate.upVotes += 1
            try upvotedCandidate.save(db)
        }
    }
    
    func getCandidate(id: UUID) async throws -> Candidate? {
        try await getCandidates().first(where: { $0.id == id })
    }
    
}
