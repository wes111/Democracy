//
//  PostFilters.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import Foundation

struct PostFilters {
    var dateFilter: DateFilter
    var sortOrder: SortOrder
    var tagsFilter: [String]
    
    init(dateFilter: DateFilter = .all, sortOrder: SortOrder = .top, categoriesFilter: [String] = []) {
        self.dateFilter = dateFilter
        self.sortOrder = sortOrder
        self.tagsFilter = categoriesFilter
    }
}
