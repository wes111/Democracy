//
//  CandidateLocalRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Factory
import Foundation

protocol CandidateLocalRepositoryProtocol {
    func getCandidates() throws -> [Candidate]
    //func updateCandidate(_ candidate: Candidate) throws
    func addCandidates(_ candidates: [Candidate]) throws
    //func initiallyStoreCandidates(_ candidates: [Candidate]) throws
    func deleteAllCandidates()
    
    func upvoteCandidate()
}

enum CandidateLocalRepositoryError: Error {
    case unexpected
}

class CandidateLocalRepository: CandidateLocalRepositoryProtocol {

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    let defaults = UserDefaults.standard
    let key = "Candidates"
    
    @Injected(\.grdbService) var grdbService
    
    init() {
        let bob = grdbService.database
    }
    
    func getCandidates() throws -> [Candidate] {
        guard let data = defaults.object(forKey: key) as? Data else {
            throw CandidateLocalRepositoryError.unexpected
        }
        return try decoder.decode([Candidate].self, from: data)
        
    }
    
    func initiallyStoreCandidates(_ candidates: [Candidate]) throws {
        let encoded = try encoder.encode(candidates)
        defaults.set(encoded, forKey: key)
    }
    
    func addCandidates(_ candidates: [Candidate]) throws {
        var currentCandidates = try getCandidates()
        currentCandidates += candidates
        let encoded = try encoder.encode(candidates)
        defaults.set(encoded, forKey: key)
    }
    
    private func updateCandidate(_ candidate: Candidate) throws {
        var candidates = try getCandidates()
        guard let index = candidates.firstIndex(where: { $0.id == candidate.id }) else {
            return print("Tried to update candidate but didn't find the candidate's ID")
        }
        candidates[index] = candidate
        let encoded = try encoder.encode(candidates)
        defaults.set(encoded, forKey: key)
    }
    
    func deleteAllCandidates() {
        defaults.removeObject(forKey: key)
    }
    
    func upvoteCandidate() {
        //
    }
    
    func upvoteCandidate(id: UUID) {
//        var upVotedCandidate = candidate
//        upVotedCandidate.upVotes += 1
//        try localRepository.updateCandidate(upVotedCandidate)
//        candidatesPublisher.send(try getCandidates())
    }
    
}
