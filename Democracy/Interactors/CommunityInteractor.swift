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
    
    func subscribeToMyCommunities() -> AnyPublisher<[Community], Never>
    func subscribeToRecommendedCommunities() -> AnyPublisher<[Community], Never>
    func subscribeToTopCommunities() -> AnyPublisher<[Community], Never>
    
    func refreshMyCommunities()
    func refreshRecommendedCommunities()
    func refreshTopCommunities()
}

struct CommunityInteractor: CommunityInteractorProtocol {
    
    @Injected(\.communityLocalRepository) var localRepository
    @Injected(\.communityRemoteRepository) var remoteRepository
    
    // TODO: Move this out of communityInteractor?
    private let representativesPublisher = PassthroughSubject<[Candidate], Never>()
    
    private let myCommunitiesPublisher = PassthroughSubject<[Community], Never>()
    private let recommendedCommunitiesPublisher = PassthroughSubject<[Community], Never>()
    private let topCommunitiesPublisher = PassthroughSubject<[Community], Never>()
    
    init() {
        
    }
    
    func subscribeToRepresentatives() -> AnyPublisher<[Candidate], Never> {
        representativesPublisher.eraseToAnyPublisher()
    }
    
    func refreshRepresentatives() {
        representativesPublisher.send(Candidate.representativePreviewArray)
    }
    
    func subscribeToMyCommunities() -> AnyPublisher<[Community], Never> {
        myCommunitiesPublisher.eraseToAnyPublisher()
    }
    
    func subscribeToRecommendedCommunities() -> AnyPublisher<[Community], Never> {
        recommendedCommunitiesPublisher.eraseToAnyPublisher()
    }
    
    func subscribeToTopCommunities() -> AnyPublisher<[Community], Never> {
        topCommunitiesPublisher.eraseToAnyPublisher()
    }
    
    func refreshMyCommunities() {
        myCommunitiesPublisher.send(Community.myCommunitiesPreviewArray)
    }
    
    func refreshRecommendedCommunities() {
        recommendedCommunitiesPublisher.send(Community.recommendedCommunitiesPreviewArray)
    }
    
    func refreshTopCommunities() {
        topCommunitiesPublisher.send(Community.topCommunitiesPreviewArray)
    }
    
}

