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

@MainActor @Observable
final class CommunitiesTabMainViewModel {
    
//    @Published var myCommunities: [Community] = []
//    @Published var recommendedCommunities: [Community] = []
//    @Published var topCommunities: [Community] = []
    var allCommunities: [Community] = []
    @ObservationIgnored @Injected(\.communityService) private var communityService
    
    private weak var coordinator: CommunitiesTabMainCoordinatorDelegate?
    
    init(coordinator: CommunitiesTabMainCoordinatorDelegate?) {
        self.coordinator = coordinator
        
        Task {
            let communities = try await self.communityService.fetchAllCommunities() // TODO: This fetch should probably be in the repository...
            allCommunities = communities
        }
    }
    
    func goToCommunity(_ community: Community) {
        coordinator?.goToCommunity(communityId: community.id)
    }
    
    func showCreateCommunityView() {
        coordinator?.showCreateCommunityView()
    }
    
}
