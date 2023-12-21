//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation
import SharedResourcesClientAndServer

struct Post: Identifiable {
    let id: String = UUID().uuidString
    let creationDate = Date()
    let title: String
    let subtitle: String?
    let body: String
    let link: Link?
    var comments: [Comment]?
    var likeCount: Int = 0
    var dislikeCount: Int = 0
    var superLikeCount: Int = 0
    let creator: User
    let community: Community = Community.preview
    var tags: [Tag]
    
    init(
        title: String,
        subtitle: String? = nil,
        body: String,
        creator: User,
        tags: [Tag],
        link: Link? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.creator = creator
        self.tags = tags
        self.link = link
    }
    
    func toViewModel(coordinator: PostCardCoordinatorDelegate?) -> PostCardViewModel {
        .init(coordinator: coordinator, post: self)
    }
}

extension Post: Hashable {
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
