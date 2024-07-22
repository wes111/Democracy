//
//  DateFilter.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/21/24.
//

import Foundation

enum DateFilter {
    case day
    case week
    case month
    case year
    case all
}

extension DateFilter: Selectable {
    
    var title: String {
        switch self {
        case .day:
            "Day"
        case .week:
            "Week"
        case .month:
            "Month"
        case .year:
            "Year"
        case .all:
            "All Time"
        }
    }
    
    var subtitle: String? {
        nil
    }
    
    var image: SystemImage? {
        nil
    }
    
    static var metaTitle: String {
        "Date Filter"
    }
}
