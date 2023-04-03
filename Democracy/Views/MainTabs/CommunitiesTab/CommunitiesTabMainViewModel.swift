//
//  CommunitiesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Combine
import Factory

protocol CommunitiesTabMainCoordinatorDelegate {
    func goToCommunity(_ community: Community)
    func showCreateCommunityView()
}

protocol CommunitiesTabMainViewModelProtocol: ObservableObject {
    var myCommunities: [Community] { get }
    var recommendedCommunities: [Community] { get }
    var topCommunities: [Community] { get }
    
    func goToCommunity(_ community: Community)
    func refreshMyCommunities()
    func refreshRecommendedCommunities()
    func refreshTopCommunities()
    func showCreateCommunityView()
}

final class CommunitiesTabMainViewModel: CommunitiesTabMainViewModelProtocol {

    @Injected(\.communityInteractor) var communityInteractor
    
    @Published var myCommunities: [Community] = []
    @Published var recommendedCommunities: [Community] = []
    @Published var topCommunities: [Community] = []
    
    let coordinator: CommunitiesTabMainCoordinatorDelegate
    
    init(coordinator: CommunitiesTabMainCoordinatorDelegate) {
        self.coordinator = coordinator
        
        communityInteractor.subscribeToMyCommunities().assign(to: &$myCommunities)
        communityInteractor.subscribeToRecommendedCommunities().assign(to: &$recommendedCommunities)
        communityInteractor.subscribeToTopCommunities().assign(to: &$topCommunities)
        
        communityInteractor.refreshMyCommunities()
        communityInteractor.refreshRecommendedCommunities()
        communityInteractor.refreshTopCommunities()
    }
    
    func goToCommunity(_ community: Community) {
        coordinator.goToCommunity(community)
    }

    func refreshMyCommunities() {
        communityInteractor.refreshMyCommunities()
    }
    
    func refreshRecommendedCommunities() {
        communityInteractor.refreshRecommendedCommunities()
    }
    
    func refreshTopCommunities() {
        communityInteractor.refreshTopCommunities()
    }
    
    func showCreateCommunityView() {
        coordinator.showCreateCommunityView()
    }
    
}
