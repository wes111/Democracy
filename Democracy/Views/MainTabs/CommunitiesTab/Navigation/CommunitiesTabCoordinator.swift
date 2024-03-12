//
//  CommunitiesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/6/23.
//

import Foundation

@MainActor @Observable
final class CommunitiesTabCoordinator {
    var isShowingCreateCommunityView = false
    var router = Router()
}

// MARK: - Child ViewModels
extension CommunitiesTabCoordinator {
    
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
    
    func goToCommunity(communityId: String) {
        router.push(CommunitiesTabPath.goToCommunity(.preview))
    }
}

extension CommunitiesTabCoordinator: SubmitCommunityCoordinatorParent {
    func dismiss() {
        isShowingCreateCommunityView = false
    }
}

extension CommunitiesTabCoordinator: CommunityCoordinatorParent {}
