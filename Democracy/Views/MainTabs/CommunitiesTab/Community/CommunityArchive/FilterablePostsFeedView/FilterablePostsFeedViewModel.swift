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
}

// MARK: - Methods
extension FilterablePostsFeedViewModel {
}
