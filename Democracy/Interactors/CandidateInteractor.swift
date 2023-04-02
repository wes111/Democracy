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
    func addCandidate(summary: String, link: String?) async throws
}

struct CandidateInteractor: CandidateInteractorProtocol {

    // Repositories:
    @Injected(\.candidateLocalRepository) var localRepository
    @Injected(\.candidateRemoteRepository) var remoteRepository
    
    // Interactors:
    @Injected(\.userInteractor) var userInteractor
    
    private var candidatesPublisher = PassthroughSubject<[Candidate], Never>()
    
    init() {}
    
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never> {
        defer {
            updateCandidates()
        }
        return candidatesPublisher.eraseToAnyPublisher()
    }
    
    func refreshCandidates() {
        //TODO: ...
        updateCandidates()
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
    
    func addCandidate(summary: String, link: String?) async throws {
        
        let user = try await userInteractor.getUser()
        let candidate = Candidate(
            id: user.id,
            userName: user.userName,
            firstName: user.firstName,
            lastName: user.lastName,
            imageName: nil,
            upVotes: 0,
            downVotes: 0,
            communityId: UUID(),
            isRepresentative: false,
            summary: summary,
            externalLink: link)
        
        try await localRepository.addCandidate(candidate)
        updateCandidates()
    }
    
}

enum CandidateInteractorError: Error {
    case unexpected
}

