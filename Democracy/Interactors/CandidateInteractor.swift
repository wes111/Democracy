//
//  CandidateInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Combine
import Factory
import Foundation
import SharedResourcesClientAndServer

protocol CandidateInteractorProtocol {
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never>
    func refreshCandidates()
    func upVoteCandidate(_ candidate: Candidate) async throws
    func downVoteCandidate(_ candidate: Candidate) async throws
    func getCandidate(id: String) async throws -> Candidate?
    func addCandidate(summary: String, link: String?, repType: RepresentativeType) async throws
    
}

struct CandidateInteractor: CandidateInteractorProtocol {

    // Repositories:
    //@Injected(\.candidateLocalRepository) var localRepository
    
    // Interactors:
   // @Injected(\.accountService) var accountService
    
    private let candidatesPublisher = PassthroughSubject<[Candidate], Never>()
    
    init() {
        updateCandidates()
    }
    
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never> {
        candidatesPublisher.eraseToAnyPublisher()
    }
    
    func refreshCandidates() {
        updateCandidates()
    }
    
    private func updateCandidates() {
//        Task {
//            do {
//                let candidates = try await localRepository.getCandidates()
//                candidatesPublisher.send(candidates)
//            } catch {
//                // print("Failed to update candidates from local repository, error: \(error)")
//            }
//        }
    }
    
    func upVoteCandidate(_ candidate: Candidate) async throws {
        //try await localRepository.upVoteCandidate(candidate)
        updateCandidates()
    }
    
    func downVoteCandidate(_ candidate: Candidate) async throws {
        //try await localRepository.downVoteCandidate(candidate)
        updateCandidates()
    }
    
    func getCandidate(id: String) async throws -> Candidate? {
        //try await localRepository.getCandidate(id: id)
        return nil
    }
    
    func addCandidate(summary: String, link: String?, repType: RepresentativeType) async throws {
        
        let user = User.preview // accountService.getUser()
        let candidate = Candidate(
            id: user.id,
            userName: user.name,
            firstName: user.name,
            lastName: user.name,
            imageName: "bernie",
            upVotes: 0,
            downVotes: 0,
            communityId: UUID().uuidString,
            isRepresentative: false,
            summary: summary,
            externalLink: link,
            repType: repType,
            badges: [.candidate, .currentRep, .popular]
        )
        
        //try await localRepository.addCandidate(candidate)
        updateCandidates()
    }
    
}

enum CandidateInteractorError: Error {
    case unexpected
}
