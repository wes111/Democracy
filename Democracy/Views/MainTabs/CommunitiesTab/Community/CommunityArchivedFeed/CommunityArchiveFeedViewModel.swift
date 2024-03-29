//
//  CommunityArchiveFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Factory
import Foundation

protocol CommunityArchiveFeedCoordinatorDelegate: PostCardCoordinatorDelegate, AnyObject {
    @MainActor func goToCommunityPostCategory(categoryId: String)
}

final class CommunityArchiveFeedViewModel: ObservableObject {
    
    private weak var coordinator: CommunityArchiveFeedCoordinatorDelegate?
    private let community: Community
    
    var categories: [CommunityCategoryViewModel] {
        Community.preview.categories.map { CommunityCategoryViewModel(name: $0) }
    }
    
    init(coordinator: CommunityArchiveFeedCoordinatorDelegate?,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
    @MainActor
    func goToCommunityPostCategory(category: CommunityCategoryViewModel) {
        coordinator?.goToCommunityPostCategory(categoryId: category.name)
    }
    
}
