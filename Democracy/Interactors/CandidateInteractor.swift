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
    
    func upVoteCandidate(_ candidate: Candidate)
    func downVoteCandidate(_ candidate: Candidate)
    func getCandidate(id: UUID) throws -> Candidate
}

struct CandidateInteractor: CandidateInteractorProtocol {

    @Injected(\.candidateLocalRepository) var localRepository
    @Injected(\.candidateRemoteRepository) var remoteRepository
    
    private var candidatesPublisher = CurrentValueSubject<[Candidate], Never>([])
    
    init() {
        // TODO: Had to make the interactor a singleton for now because the init is called to many times. fix.
        refreshCandidates()
        getCandidates()
    }
    
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never> {
        candidatesPublisher.eraseToAnyPublisher()
    }
    
    func refreshCandidates() {
        //feches from remote repository and then updates local.
    }
    
    func upVoteCandidate(_ candidate: Candidate) {
        do {
            //update local repository
            var upVotedCandidate = candidate
            upVotedCandidate.upVotes += 1
            try localRepository.updateCandidate(upVotedCandidate)
            candidatesPublisher.send(try localRepository.getCandidates())
        } catch {
            
        }
        //update remote repository
        getCandidates()
    }
    
    func downVoteCandidate(_ candidate: Candidate) {
        print("Downvoted candidate")
    }
    
    func getCandidate(id: UUID) throws -> Candidate {
        guard let candidate = try localRepository.getCandidates().first(where: { $0.id == id }) else {
            throw CandidateInteractorError.unexpected
        }
        return candidate
    }
    
    private func getCandidates() {
        do {
            candidatesPublisher.send(try localRepository.getCandidates())
        } catch {
            print("Failed to get candidates from local storage, error: \(error)")
        }
    }
    
}

enum CandidateInteractorError: Error {
    case unexpected
}

