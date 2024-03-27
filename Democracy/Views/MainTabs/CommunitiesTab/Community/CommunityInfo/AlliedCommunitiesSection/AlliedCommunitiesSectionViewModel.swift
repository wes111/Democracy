//
//  AlliedCommunitiesSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import Foundation

class AlliedCommunitiesSectionViewModel {
    
    let alliedCommunities: [AlliedCommunityViewModel]
    let title = "Allied Communities"
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    init(alliedCommunities: [Community], coordinator: CommunitiesCoordinatorDelegate?) {
        self.alliedCommunities = alliedCommunities.map { .init($0) }
        self.coordinator = coordinator
    }
    
    @MainActor
    func onTapCommunity(community: Community) {
        coordinator?.goToCommunity(community: community)
    }
}
