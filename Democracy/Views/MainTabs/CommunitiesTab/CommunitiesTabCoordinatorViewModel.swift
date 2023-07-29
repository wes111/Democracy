//
//  CommunitiesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/6/23.
//

import Foundation

class CommunitiesTabCoordinatorViewModel: ObservableObject {
    
    @Published var isShowingCreateCommunityView = false
    @Published var router = Router()
    
    lazy var createCommunityViewModel: CreateCommunityViewModel = {
        CreateCommunityViewModel(coordinator: self)
    }()
    
    lazy var communitiesTabMainViewModel: CommunitiesTabMainViewModel = {
        CommunitiesTabMainViewModel(coordinator: self)
    }()
    
    init() {}
    
    func communityCoordinatorViewModel(community: Community) -> CommunityCoordinatorViewModel {
        .init(
            community: community,
            router: router,
            parentCoordinator: self
        )
    }
    
}

extension CommunitiesTabCoordinatorViewModel: CommunitiesTabMainCoordinatorDelegate {
    
    func showCreateCommunityView() {
        isShowingCreateCommunityView = true
    }
    
    func goToCommunity(communityId: UUID) {
        // TODO: Add actual community.
        router.push(CommunitiesTabPath.goToCommunity(.preview))
    }
}

extension CommunitiesTabCoordinatorViewModel: CreateCommunityCoordinatorDelegate {
    
    func close() {
        isShowingCreateCommunityView = false
    }
}

extension CommunitiesTabCoordinatorViewModel: CommunityCoordinatorParent {}
