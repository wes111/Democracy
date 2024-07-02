//
//  CommunityArchiveFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Factory
import Foundation

@MainActor
final class CommunityArchiveFeedViewModel: ObservableObject {
    
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    private let community: Community
    
    var categories: [CommunityCategoryViewModel] {
        Community.preview.categories.map { CommunityCategoryViewModel(name: $0) }
    }
    
    init(coordinator: CommunitiesCoordinatorDelegate?,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
    func goToCommunityPostCategory(category: CommunityCategoryViewModel) {
        coordinator?.goToCommunityPostCategory(categoryId: category.name, community: community)
    }
    
}
