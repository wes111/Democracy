//
//  CategoryCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

protocol CategoryCardCoordinatorDelegate {
}

protocol CategoryCardViewModelProtocol: ObservableObject {
    
    var category: String { get }
    var postCount: Int { get }
}

class CategoryCardViewModel: CategoryCardViewModelProtocol {
    
    let category: String
    
    init(category: String) {
        self.category = category
    }
    
    var postCount: Int {
        return 50 // TODO: ...
    }
    
}
