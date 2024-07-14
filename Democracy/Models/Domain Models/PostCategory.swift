//
//  PostCategory.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/13/24.
//

import Foundation
import SharedResourcesClientAndServer

struct PostCategory: Hashable, Codable, Identifiable {
    let id: String
    let name: String
    let imageUrl: URL?
    let postCount: Int
    let communityId: String
    let creationDate: Date
}

extension PostCategoryDTO {
    func toPostCategory() -> PostCategory {
        .init(
            id: id,
            name: name,
            imageUrl: imageUrl,
            postCount: postCount,
            communityId: communityId,
            creationDate: creationDate
        )
    }
}
