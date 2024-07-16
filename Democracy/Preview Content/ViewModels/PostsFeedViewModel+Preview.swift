//
//  CommunityHomeFeedViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension PostsFeedViewModel {
    static let preview = PostsFeedViewModel(
        community: .preview,
        query: .approved,
        coordinator: CommunitiesCoordinator.preview
    )
}

extension FilterablePostsFeedViewModel {
    static let preview2 = FilterablePostsFeedViewModel(
        community: .preview,
        query: .approved,
        coordinator: CommunitiesCoordinator.preview
    )
}
