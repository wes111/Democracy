//
//  CommunityCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/3/24.
//

import Foundation
import Factory

@MainActor @Observable
final class CommunityCardViewModel {
    private let community: Community
    @ObservationIgnored @Injected(\.membershipService) private var membershipService
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    init(community: Community, coordinator: CommunitiesCoordinatorDelegate?) {
        self.community = community
        self.coordinator = coordinator
    }
}

// MARK: - Computed Properties
extension CommunityCardViewModel {
    
    var name: String {
        community.name
    }
    
    var tagline: String {
        community.tagline
    }
    
    var membershipButtonTitle: String {
        "Join"
        //membership == nil ? "Join" : "Leave"
    }
}

// MARK: - Methods
extension CommunityCardViewModel {
    
    func onTap() {
        coordinator?.goToCommunity(community: community)
    }
    
    func toggleCommunityMembership() async {
         try? await Task.sleep(seconds: 2.0)
        // TODO: we should ask membershipService to toggle membership....
        do {
//            if let membership {
//                try await membershipService.leaveCommunity(membership: membership)
//            } else {
//                try await membershipService.joinCommunity(community)
//            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
