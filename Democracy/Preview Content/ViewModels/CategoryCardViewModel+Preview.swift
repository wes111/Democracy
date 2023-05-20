//
//  CategoryCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

extension CategoryCardViewModel {
    static let preview = CategoryCardViewModel(category: "Preview Category")
    
    static let previewArray: [CategoryCardViewModel] = [
        CategoryCardViewModel(category: "Preview Category"),
        CategoryCardViewModel(category: "Preview Category 1"),
        CategoryCardViewModel(category: "Preview Category 2"),
        CategoryCardViewModel(category: "Preview Category 3"),
        CategoryCardViewModel(category: "Preview Category 4"),
        CategoryCardViewModel(category: "Preview Category 5"),
        CategoryCardViewModel(category: "Preview Category Longer Title"),
        CategoryCardViewModel(category: "Preview Category Very Very Very Longer Title"),
        CategoryCardViewModel(category: "Preview Category 8"),
        CategoryCardViewModel(category: "Preview Category 9")
    ]
}
