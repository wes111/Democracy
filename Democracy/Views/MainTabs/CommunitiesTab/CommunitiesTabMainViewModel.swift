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
    @MainActor func goToCommunity(community: Community)
    @MainActor func showCreateCommunityView()
}

@MainActor @Observable
final class CommunitiesTabMainViewModel {
    
    var allCommunities: [Community] = []
    var category: CommunitiesCategory = .isMemberOf
    
    @ObservationIgnored @Injected(\.communityService) private var communityService
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    
    private weak var coordinator: CommunitiesTabMainCoordinatorDelegate?
    
    init(coordinator: CommunitiesTabMainCoordinatorDelegate?) {
        self.coordinator = coordinator
        
        Task {
            let communities = try await self.communityService.fetchAllCommunities() // TODO: This fetch should probably be in the repository...
            allCommunities = communities
            
            let bob = try await membershipService.userMemberships()
        }
    }
    
    func goToCommunity(_ community: Community) {
        coordinator?.goToCommunity(community: community)
    }
    
    func showCreateCommunityView() {
        coordinator?.showCreateCommunityView()
    }
    
}
