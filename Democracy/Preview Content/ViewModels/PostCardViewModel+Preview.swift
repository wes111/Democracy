//
//  PostCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension PostCardViewModel {
    static let preview = PostCardViewModel(coordinator: CommunityCoordinatorViewModel.preview, post: Post.preview)
    
    static let previewArray: [PostCardViewModel] = [
        preview, preview, preview, preview, preview
    ]
}
