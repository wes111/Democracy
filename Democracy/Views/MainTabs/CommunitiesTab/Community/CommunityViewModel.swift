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
        
        getMemberships() // TODO: Temp... see note below.
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
    
    // TODO: We need to subscribe to a stream of memberships... This is temporary.
    func getMemberships() {
        Task {
            do {
                let memberships = try await membershipService.userMemberships()
                membership = memberships.first(where: { $0.community == community })
            } catch {
                print(error.localizedDescription)
            }
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
