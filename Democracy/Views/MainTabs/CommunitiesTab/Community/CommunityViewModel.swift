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

final class CommunityViewModel: ObservableObject {
    
    @Published var isShowingNavigationBar = true
    private var cancellables = Set<AnyCancellable>()

    private weak var coordinator: CommunityCoordinatorDelegate?
    let community: Community
    var canCreatePost: Bool {
        return true
        // Communityinteractor.canMakePostsInThisCommunity
    }
    
    lazy var leadingButtons: [ToolBarLeadingContent] = {
        [.title(community.name), .back(goBack)]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        []
    }()
    
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
