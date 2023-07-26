//
//  CommunityArchiveFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Factory
import Foundation

protocol CommunityArchiveFeedCoordinatorDelegate: PostCardCoordinatorDelegate {
    func goToCommunityPostCategory(categoryId: UUID)
}

final class CommunityArchiveFeedViewModel: ObservableObject {
    
    private let coordinator: CommunityArchiveFeedCoordinatorDelegate
    private let community: Community
    
    var categories: [CommunityCategoryViewModel] {
        CommunityCategory.previewArray.map { $0.toCommunityCategoryViewModel() }
    }
    
    init(coordinator: CommunityArchiveFeedCoordinatorDelegate,
         community: Community
    ) {
        self.coordinator = coordinator
        self.community = community
    }
    
    func goToCommunityPostCategory(category: CommunityCategoryViewModel) {
        coordinator.goToCommunityPostCategory(categoryId: category.id)
    }
    
}
