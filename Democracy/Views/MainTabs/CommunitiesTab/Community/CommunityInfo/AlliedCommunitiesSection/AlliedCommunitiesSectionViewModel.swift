//
//  AlliedCommunitiesSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/24/23.
//

import Foundation

protocol AlliedCommunitiesSectionViewModelCoordinatorDelegate {
    
    func goToCommunityView(id: UUID)
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
    
    func onTapCommunity(id: UUID) {
        coordinator.goToCommunityView(id: id)
    }
    
}
