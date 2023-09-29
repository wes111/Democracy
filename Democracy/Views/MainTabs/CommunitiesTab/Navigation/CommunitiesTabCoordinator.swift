//
//  CommunitiesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/6/23.
//

import Foundation

final class CommunitiesTabCoordinator: Coordinator {
    
}

// MARK: - Child ViewModels
extension CommunitiesTabCoordinator {
    
    func createCommunityViewModel() -> CreateCommunityViewModel {
        CreateCommunityViewModel(coordinator: self)
    }
    
    func communitiesTabMainViewModel() -> CommunitiesTabMainViewModel {
        CommunitiesTabMainViewModel(coordinator: self)
    }
    
    func communityCoordinatorViewModel(community: Community) -> CommunityCoordinator {
        .init(
            community: community,
            router: router,
            parentCoordinator: self
        )
    }
    
}

// MARK: - Protocols
extension CommunitiesTabCoordinator: CommunitiesTabMainCoordinatorDelegate {
    
    func showCreateCommunityView() {
        router.push(CommunitiesTabPath.goToCreateCommunity)
    }
    
    func goToCommunity(communityId: String) {
        // TODO: Add actual community.
        router.push(CommunitiesTabPath.goToCommunity(.preview))
    }
}

extension CommunitiesTabCoordinator: CreateCommunityCoordinatorDelegate {
    func close() {
        router.pop()
    }
}

extension CommunitiesTabCoordinator: CommunityCoordinatorParent {}
