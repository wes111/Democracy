//
//  CommunityArchiveViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/24.
//

import Foundation

@MainActor @Observable
final class CommunityArchiveViewModel {
    
    let community: Community
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    init(community: Community, coordinator: CommunitiesCoordinatorDelegate?) {
        self.community = community
        self.coordinator = coordinator
    }
}

// MARK: - Methods
extension CommunityArchiveViewModel {
    func goToCommunityPostCategory(category: PostCategory) {
        coordinator?.goToCommunityPostCategory(category: category, community: community)
    }
}

// MARK: - Computed Properties
extension CommunityArchiveViewModel {
    var categories: [PostCategory] {
        community.categories
    }
}
