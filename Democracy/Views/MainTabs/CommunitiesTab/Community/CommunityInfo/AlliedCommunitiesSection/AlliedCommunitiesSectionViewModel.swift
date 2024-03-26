//
//  AlliedCommunitiesSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import Foundation

protocol AlliedDelegate: AnyObject {
    
    @MainActor func goToCommunityView(community: Community)
}

class AlliedCommunitiesSectionViewModel {
    
    let alliedCommunities: [AlliedCommunityViewModel]
    let title = "Allied Communities"
    private weak var coordinator: AlliedDelegate?
    
    init(alliedCommunities: [Community],
         coordinator: AlliedDelegate?
    ) {
        self.alliedCommunities = alliedCommunities.map { .init($0) }
        self.coordinator = coordinator
    }
    
    @MainActor
    func onTapCommunity(community: Community) {
        coordinator?.goToCommunityView(community: community)
    }
    
}
