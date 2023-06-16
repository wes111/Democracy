//
//  CategoryCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

extension CategoryCardViewModel {
    static let preview = CategoryCardViewModel(category: CommunityCategory.preview)
    
    static let previewArray: [CategoryCardViewModel] = {
        var array: [CategoryCardViewModel] = []
        CommunityCategory.previewArray.forEach({ category in
            array.append(.init(category: category))
            print(category)
        })
        return array
    }()
    
}
