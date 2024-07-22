//
//  SortOrder.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/21/24.
//

import Foundation

enum SortOrder {
    case recent
    case top
}

extension SortOrder: Selectable {
    var title: String {
        switch self {
        case .recent:
            "Newest"
        case .top:
            "Top"
        }
    }
    
    var subtitle: String? {
        nil
    }
    
    var image: SystemImage? {
        nil
    }
    
    static var metaTitle: String {
        "Sort Order"
    }
}
