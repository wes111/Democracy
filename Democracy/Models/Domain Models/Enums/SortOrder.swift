//
//  SortOrder.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/21/24.
//

import Foundation

enum SortOrder {
    case newest
    case oldest
    case topRated
    case lowRated
}

extension SortOrder: Selectable {
    static let metaTitle: String = "Sort Order"
    static let metaImage: SystemImage = .arrowUpArrowDown
    
    var title: String {
        switch self {
        case .newest:
            "Newest"
        case .oldest:
            "Oldest"
        case .topRated:
            "Top Rated"
        case .lowRated:
            "Lowest Rated"
        }
    }
    
    var subtitle: String? {
        nil
    }
    
    var image: SystemImage? {
        nil
    }
}
