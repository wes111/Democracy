//
//  AlliedCommunitiesSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import Foundation

protocol AlliedDelegate: AnyObject {
    
    @MainActor func goToCommunityView(id: String)
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
    func onTapCommunity(id: String) {
        coordinator?.goToCommunityView(id: id)
    }
    
}
