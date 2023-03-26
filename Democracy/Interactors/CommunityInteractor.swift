//
//  CommunityInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/13/23.
//

import Combine
import Factory

protocol CommunityInteractorProtocol {
    func subscribeToRepresentatives() -> AnyPublisher<[Candidate], Never>
    func refreshRepresentatives()
    func subscribeToCommunities() -> AnyPublisher<[Community], Never>
    func refreshCommunities()
}

struct CommunityInteractor: CommunityInteractorProtocol {
    
    @Injected(\.communityLocalRepository) var localRepository
    @Injected(\.communityRemoteRepository) var remoteRepository
    
    private let representativesPublisher = PassthroughSubject<[Candidate], Never>()
    private let communitiesPublisher = PassthroughSubject<[Community], Never>()
    
    init() {
        
    }
    
    func subscribeToRepresentatives() -> AnyPublisher<[Candidate], Never> {
        representativesPublisher.eraseToAnyPublisher()
    }
    
    func refreshRepresentatives() {
        representativesPublisher.send(Candidate.representativePreviewArray)
    }
    
    
    //TODO: Move these, not the responsibility of communityInteractor.
    func subscribeToCommunities() -> AnyPublisher<[Community], Never> {
        communitiesPublisher.eraseToAnyPublisher()
    }
    
    func refreshCommunities() {
        communitiesPublisher.send(Community.previewArray)
    }
    
}

