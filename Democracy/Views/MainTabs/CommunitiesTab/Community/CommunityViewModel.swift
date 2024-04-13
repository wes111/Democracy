//
//  CommunityViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import Factory
import Foundation

@MainActor @Observable
final class CommunityViewModel {

    var isShowingProgress: Bool = false
    var membership: Membership?
    var selectedTab: CommunityTab = .feed
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    let community: Community
    
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    
    init(coordinator: CommunitiesCoordinatorDelegate, community: Community) {
        self.coordinator = coordinator
        self.community = community
        
        startMembershipsTask()
    }
}

// MARK: - Computed Properties
extension CommunityViewModel {
    
    var leadingButtons: [ToolBarLeadingContent] {
        [.back(goBack)]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.menu([
            .init(title: "Create Post", action: showCreatePostView)
        ])]
    }
}

// MARK: - Methods
extension CommunityViewModel {
    
    func toggleCommunityMembership() async {
        do {
            if let membership {
                try await membershipService.leaveCommunity(membership: membership)
            } else {
                try await membershipService.joinCommunity(community)
            }
        } catch {
            print(error.localizedDescription)
        }
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

// MARK: - Private Methods
private extension CommunityViewModel {
    func startMembershipsTask() {
        Task {
            for await membershipsArray in await membershipService.membershipsStream() {
                membership = membershipsArray.first(where: { $0.community == community })
            }
            print("Did we make it here?")
        }
        
    }
}
