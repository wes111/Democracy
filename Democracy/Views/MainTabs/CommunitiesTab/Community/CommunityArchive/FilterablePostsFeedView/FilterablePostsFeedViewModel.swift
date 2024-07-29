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
        .init(
            communityTags: community.tags,
            postFilters: postFilters,
            onUpdateFilters: onUpdatePostFilters(_:)
        )
    }
    
    func onUpdatePostFilters(_ postFilters: PostFilters) {
        self.postFilters = postFilters
        isShowingFilters = false
    }
}

// MARK: - Methods
extension FilterablePostsFeedViewModel {
}
