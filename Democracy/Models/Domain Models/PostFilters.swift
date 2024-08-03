//
//  PostFilters.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import Foundation
import SharedResourcesClientAndServer

struct PostFilters: Equatable {
    var approved: PostApprovedFilter
    var archived: PostArchivedFilter
    var categoriesFilter: PostCategory? // Posts can only belong to one category.
    var sortOrder: SortOrder
    var tagsFilter: [CommunityTag] // Posts can have multiple tags.
    var dateFilter: DateFilter
    
    init(
        approved: PostApprovedFilter = .approved,
        archived: PostArchivedFilter = .noFilter,
        categoriesFilter: PostCategory? = nil,
        sortOrder: SortOrder = .topRated,
        tagsFilter: [CommunityTag] = [],
        dateFilter: DateFilter = .noFilter
    ) {
        self.approved = approved
        self.archived = archived
        self.categoriesFilter = categoriesFilter
        self.sortOrder = sortOrder
        self.tagsFilter = tagsFilter
        self.dateFilter = dateFilter
    }
}

// MARK: - Computed Properties
extension PostFilters {
    
    var earliestDate: Date {
        switch dateFilter {
        case .day:
            Calendar.current.date(byAdding: .hour, value: -24, to: .now)!
        case .week:
            Calendar.current.date(byAdding: .weekOfYear, value: -1, to: .now)!
        case .month:
            Calendar.current.date(byAdding: .month, value: -1, to: .now)!
        case .year:
            Calendar.current.date(byAdding: .year, value: -1, to: .now)!
        case .noFilter:
            Calendar.current.date(byAdding: .era, value: -1, to: .now)!
        }
    }
}

enum PostArchivedFilter {
    case archived
    case notArchived
    case noFilter
}

enum PostApprovedFilter {
    case approved
    case notApproved
    case noFilter
}
