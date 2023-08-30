//
//  CommunitiesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/6/23.
//

import Foundation

final class CommunitiesTabCoordinator: Coordinator {
    
    @Published var isShowingCreateCommunityView = false
    
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
        isShowingCreateCommunityView = true
    }
    
    func goToCommunity(communityId: UUID) {
        // TODO: Add actual community.
        router.push(CommunitiesTabPath.goToCommunity(.preview))
    }
}

extension CommunitiesTabCoordinator: CreateCommunityCoordinatorDelegate {
    
    func close() {
        isShowingCreateCommunityView = false
    }
}

extension CommunitiesTabCoordinator: CommunityCoordinatorParent {}
