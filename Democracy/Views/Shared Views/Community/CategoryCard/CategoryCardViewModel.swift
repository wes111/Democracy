//
//  CategoryCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

protocol CategoryCardCoordinatorDelegate {
}

class CategoryCardViewModel: ObservableObject {
    
    let category: CommunityCategory
    
    init(category: CommunityCategory) {
        self.category = category
    }
    
    var postCount: Int {
        return 50 // TODO: ...
    }
    
    var imageName: String {
        category.imageName
    }
    
}
