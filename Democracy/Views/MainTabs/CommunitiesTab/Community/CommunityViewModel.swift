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
    
    var leadingContent: [TopBarContent] {
        [.back(goBack)]
    }
    
    var centerContent: [TopBarContent] {
        [.title(community.name, size: .large)]
    }
    
    var trailingContent: [TopBarContent] {
        [.menu([
            .init(title: "Create Post", action: showCreatePostView)
        ])]
    }
    
    var membershipButtonTitle: String {
        membership == nil ? "Join" : "Leave"
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
    
    func communityHomeFeedViewModel() -> CommunityHomeFeedViewModel {
        CommunityHomeFeedViewModel(community: community, coordinator: coordinator)
    }
    
    func communityInfoViewModel() -> CommunityInfoViewModel {
        CommunityInfoViewModel(coordinator: coordinator, community: community)
    }
    
    func communityArchiveFeedViewModel() -> CommunityArchiveFeedViewModel {
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
            membership = await membershipService.currentValue.first(where: { $0.community == community })
            for await membershipsArray in await membershipService.membershipsStream() {
                membership = membershipsArray.first(where: { $0.community == community })
            }
        }
    }
}
