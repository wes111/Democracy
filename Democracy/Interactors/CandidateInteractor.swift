//
//  CandidateInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Combine
import Factory
import Foundation

protocol CandidateInteractorProtocol {
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never>
    func refreshCandidates()
    func upVoteCandidate(_ candidate: Candidate) async throws
    func downVoteCandidate(_ candidate: Candidate) async throws
    func getCandidate(id: UUID) async throws -> Candidate?
    func addCandidate(_ candidate: Candidate) async throws
}

struct CandidateInteractor: CandidateInteractorProtocol {

    @Injected(\.candidateLocalRepository) var localRepository
    @Injected(\.candidateRemoteRepository) var remoteRepository
    
    private var candidatesPublisher = PassthroughSubject<[Candidate], Never>()
    
    init() {}
    
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never> {
        defer {
            updateCandidates()
        }
        return candidatesPublisher.eraseToAnyPublisher()
    }
    
    func refreshCandidates() {
        //feches from remote repository and then updates local.
    }
    
    private func updateCandidates() {
        Task {
            do {
                let candidates = try await localRepository.getCandidates()
                candidatesPublisher.send(candidates)
            } catch {
                print("Failed to update candidates from local repository, error: \(error)")
            }
        }
    }
    
    func upVoteCandidate(_ candidate: Candidate) async throws {
        try await localRepository.upVoteCandidate(candidate)
        updateCandidates()
    }
    
    func downVoteCandidate(_ candidate: Candidate) async throws {
        try await localRepository.downVoteCandidate(candidate)
        updateCandidates()
    }
    
    func getCandidate(id: UUID) async throws -> Candidate? {
        try await localRepository.getCandidate(id: id)
    }
    
    func addCandidate(_ candidate: Candidate) async throws {
        try await localRepository.addCandidate(candidate)
        updateCandidates()
    }
    
}

enum CandidateInteractorError: Error {
    case unexpected
}

