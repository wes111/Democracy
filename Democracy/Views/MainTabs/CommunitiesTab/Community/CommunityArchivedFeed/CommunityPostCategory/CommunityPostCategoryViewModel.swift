//
//  CommunityPostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

protocol CommunityPostCategoryCoordinatorDelegate: PostCardCoordinatorDelegate {
    
}

protocol CommunityPostCategoryViewModelProtocol: ObservableObject {
    var community: Community { get }
    var category: String { get }
    var posts: [PostCardViewModel] { get }
    func refresh() 
}

class CommunityPostCategoryViewModel: CommunityPostCategoryViewModelProtocol {
    
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
