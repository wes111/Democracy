//
//  AlliedCommunitiesSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import Foundation

protocol AlliedCommunitiesSectionViewModelCoordinatorDelegate {
    
    func goToCommunityView(id: String)
}

class AlliedCommunitiesSectionViewModel {
    
    let alliedCommunities: [AlliedCommunityViewModel]
    let title = "Allied Communities"
    private let coordinator: AlliedCommunitiesSectionViewModelCoordinatorDelegate
    
    init(alliedCommunities: [Community],
         coordinator: AlliedCommunitiesSectionViewModelCoordinatorDelegate
    ) {
        self.alliedCommunities = alliedCommunities.map { .init($0) }
        self.coordinator = coordinator
    }
    
    func onTapCommunity(id: String) {
        coordinator.goToCommunityView(id: id)
    }
    
}
