//
//  CommunityPostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

protocol CommunityPostCategoryCoordinatorDelegate: PostCardCoordinatorDelegate {
    
}

class CommunityPostCategoryViewModel: ObservableObject  {
    
    let community: Community
    let category: CommunityCategory
    
    init(community: Community, category: CommunityCategory) {
        self.community = community
        self.category = category
    }
    
    var posts: [PostCardViewModel] {
        return PostCardViewModel.previewArray
    }
    
    func refresh() {
        print("Refreshed.")
    }
    
}
