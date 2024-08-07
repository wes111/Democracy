//
//  CommunityPostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

class CommunityCategoryPostsViewModel: ObservableObject {
    
    @Published var searchText = ""
    
    let community: Community
    let category: String
    
    init(community: Community, category: String) {
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
