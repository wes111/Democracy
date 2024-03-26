//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import Factory
import Foundation

protocol CommunityCoordinatorDelegate: 
    CommunityHomeFeedCoordinatorDelegate, CommunityInfoCoordinatorDelegate,
        CommunityArchiveFeedCoordinatorDelegate, AnyObject {
    @MainActor func showCreatePostView()
    @MainActor func goBack()
}

@MainActor @Observable
final class CommunityViewModel {

    var selectedTab: CommunityTab = .feed
    private weak var coordinator: CommunityCoordinatorDelegate?
    let community: Community
    
    var leadingButtons: [ToolBarLeadingContent] {
        [.back(goBack)]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.menu([
            .init(title: "Create Post", action: showCreatePostView)
        ])]
    }
    
    init(coordinator: CommunityCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
    @MainActor
    func showCreatePostView() {
        coordinator?.showCreatePostView()
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
    
    @MainActor
    func goBack() {
        coordinator?.goBack()
    }
    
}
