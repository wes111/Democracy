//
//  CommunitiesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Combine
import Foundation
import Factory

protocol CommunitiesTabMainCoordinatorDelegate: AnyObject {
    @MainActor func goToCommunity(communityId: String)
    @MainActor func showCreateCommunityView()
}

final class CommunitiesTabMainViewModel: ObservableObject {

    @Injected(\.communityInteractor) var communityInteractor
    
    @Published var myCommunities: [Community] = []
    @Published var recommendedCommunities: [Community] = []
    @Published var topCommunities: [Community] = []
    
    private weak var coordinator: CommunitiesTabMainCoordinatorDelegate?
    
    init(coordinator: CommunitiesTabMainCoordinatorDelegate?) {
        self.coordinator = coordinator
        
        communityInteractor.subscribeToMyCommunities().assign(to: &$myCommunities)
        communityInteractor.subscribeToRecommendedCommunities().assign(to: &$recommendedCommunities)
        communityInteractor.subscribeToTopCommunities().assign(to: &$topCommunities)
        
        communityInteractor.refreshMyCommunities()
        communityInteractor.refreshRecommendedCommunities()
        communityInteractor.refreshTopCommunities()
    }
    
    @MainActor
    func goToCommunity(_ community: Community) {
        coordinator?.goToCommunity(communityId: community.id)
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
    
    @MainActor
    func showCreateCommunityView() {
        coordinator?.showCreateCommunityView()
    }
    
}
