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
}

protocol CommunitiesTabMainViewModelProtocol: ObservableObject {
    var communities: [Community] { get }
    func goToCommunity(_ community: Community)
    func refreshCommunities()
}

final class CommunitiesTabMainViewModel: CommunitiesTabMainViewModelProtocol {
    
    @Injected(\.communityInteractor) var communityInteractor
    @Published var communities: [Community] = []
    let coordinator: CommunitiesTabMainCoordinatorDelegate
    
    init(coordinator: CommunitiesTabMainCoordinatorDelegate) {
        self.coordinator = coordinator
        
        communityInteractor.subscribeToCommunities().assign(to: &$communities)
        communityInteractor.refreshCommunities()
    }
    
    func goToCommunity(_ community: Community) {
        coordinator.goToCommunity(community)
    }
    
    func refreshCommunities() {
        communityInteractor.refreshCommunities()
    }
    
}
