//
//  PostViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension PostViewModel {
    static let preview = PostViewModel(
        coordinator: CommunitiesCoordinator.preview,
        post: Post.preview
    )
}
