//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import Factory
import Foundation

protocol CommunityCoordinatorDelegate: CommunityHomeFeedCoordinatorDelegate, CommunityInfoCoordinatorDelegate, CommunityArchiveFeedCoordinatorDelegate, AnyObject {
    func showCreatePostView()
    func goBack()
}

final class CommunityViewModel: ObservableObject {
    
    @Published var isShowingNavigationBar = true
    private var cancellables = Set<AnyCancellable>()

    private weak var coordinator: CommunityCoordinatorDelegate?
    let community: Community
    var canCreatePost: Bool {
        return true
        // Communityinteractor.canMakePostsInThisCommunity
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [
            .back : {},
            .close : {}
        ]
    }
    
    init(coordinator: CommunityCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
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
    
    func goBack() {
        coordinator?.goBack()
    }
    
}
