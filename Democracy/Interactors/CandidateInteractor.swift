//
//  CandidateInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Combine
import Factory

protocol CandidateInteractorProtocol {
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never>
    func refreshPosts()
}

struct CandidateInteractor: CandidateInteractorProtocol {
    
    @Injected(\.candidateLocalRepository) var localRepository
    @Injected(\.candidateRemoteRepository) var remoteRepository
    
    private var candidatesPublisher = PassthroughSubject<[Candidate], Never>()
    
    init() {
        
    }
    
    func subscribeToCandidates() -> AnyPublisher<[Candidate], Never> {
        candidatesPublisher.eraseToAnyPublisher()
    }
    
    func refreshPosts() {
        candidatesPublisher.send(Candidate.previewArray)
    }
    
}

