//
//  FilterPostsViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/21/24.
//

import Foundation

extension FilterPostsViewModel {
    static var preview: FilterPostsViewModel {
        .init(communityTags: Community.preview.tags, postFilters: .preview, onUpdateFilters: { _ in })
    }
}
