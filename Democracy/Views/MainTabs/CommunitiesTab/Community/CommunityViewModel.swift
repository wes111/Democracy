//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Factory
import Foundation

protocol CommunityCoordinatorDelegate: CommunityHomeFeedCoordinatorDelegate, CommunityInfoCoordinatorDelegate, CommunityArchiveFeedCoordinatorDelegate {
    func showCreatePostView()
}

protocol CommunityViewModelProtocol: ObservableObject {
    var community: Community { get }
    var coordinator: CommunityCoordinatorDelegate { get }
    var canCreatePost: Bool { get }
    
    func showCreatePostView()
    func getCommunityHomeFeedViewModel() -> CommunityHomeFeedViewModel
    func getCommunityInfoViewModel() -> CommunityInfoViewModel
    func getCommunityArchiveFeedViewModel() -> CommunityArchiveFeedViewModel
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
    
    func showCreatePostView() {
        coordinator.showCreatePostView()
    }
    
    func getCommunityHomeFeedViewModel() -> CommunityHomeFeedViewModel {
        CommunityHomeFeedViewModel(coordinator: coordinator)
    }
    
    func getCommunityInfoViewModel() -> CommunityInfoViewModel {
        CommunityInfoViewModel(coordinator: coordinator, community: community)
    }
    
    func getCommunityArchiveFeedViewModel() -> CommunityArchiveFeedViewModel {
        CommunityArchiveFeedViewModel(coordinator: coordinator, community: community)
    }
    
}
