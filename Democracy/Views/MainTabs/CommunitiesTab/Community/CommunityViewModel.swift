//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

protocol CommunityCoordinatorDelegate: CommunityHomeFeedCoordinatorDelegate, CommunityInfoCoordinatorDelegate {
    func go()
    func showCreatePostView()
}

protocol CommunityViewModelProtocol: ObservableObject {
    var community: Community { get }
    var coordinator: CommunityCoordinatorDelegate { get }
    var canCreatePost: Bool { get }
    
    func go()
    func showCreatePostView()
}

final class CommunityViewModel: CommunityViewModelProtocol {

    let coordinator: CommunityCoordinatorDelegate
    let community: Community
    var canCreatePost: Bool {
        return true
        // Communityinteractor.canMakePostsInThisCommunity
    }
    
    init(coordinator: CommunityCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
    func go() {
        coordinator.go()
    }
    
    func showCreatePostView() {
        coordinator.showCreatePostView()
    }
    
}
