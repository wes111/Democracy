//
//  CommunitiesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/6/23.
//

import Foundation

class CommunitiesTabCoordinatorViewModel: ObservableObject {
    
    @Published var isShowingCreateCommunityView = false
    
    /// We only want one router for the Community Tab.
    lazy var router: Router = {
        Router()
    }()
    
    lazy var createCommunityViewModel: CreateCommunityViewModel = {
        CreateCommunityViewModel(coordinator: self)
    }()
    
    lazy var communitiesTabMainViewModel: CommunitiesTabMainViewModel = {
        CommunitiesTabMainViewModel(coordinator: self)
    }()
    
    init() {}
    
    func communityCoordinatorViewModel(community: Community) -> CommunityCoordinatorViewModel {
        .init(community: community, router: router)
    }
    
}

extension CommunitiesTabCoordinatorViewModel: CommunitiesTabMainCoordinatorDelegate {
    
    func showCreateCommunityView() {
        isShowingCreateCommunityView = true
    }
    
    func goToCommunity(_ community: Community) {
        router.push(CommunitiesTabPath.goToCommunity(community))
    }
}

extension CommunitiesTabCoordinatorViewModel: CreateCommunityCoordinatorDelegate {
    
    func close() {
        isShowingCreateCommunityView = false
    }
}
