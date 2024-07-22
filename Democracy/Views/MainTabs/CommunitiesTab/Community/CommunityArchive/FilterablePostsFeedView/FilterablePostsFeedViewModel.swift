//
//  FilterablePostsFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/15/24.
//

import Foundation

@MainActor @Observable
final class FilterablePostsFeedViewModel: PostsFeedViewModel {
    let categoryName: String = "Todo Category"
    var isShowingFilters: Bool = false
    var postFilters = PostFilters()
    
    var filterPostsViewModel: FilterPostsViewModel {
        .init(postFilters: postFilters)
    }
}

// MARK: - Methods
extension FilterablePostsFeedViewModel {
}
