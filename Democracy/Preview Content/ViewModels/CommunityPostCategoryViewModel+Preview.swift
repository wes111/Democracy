//
//  CommunityPostCategoryViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation

extension CommunityCategoryPostsViewModel {
    @MainActor static let preview = CommunityCategoryPostsViewModel(
        community: Community.preview,
        category: PostCategory.preview
    )
}
