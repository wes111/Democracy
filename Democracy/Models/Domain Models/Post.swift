//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation
import SharedResourcesClientAndServer

// Sent to backend.
struct PostDTO {
    let title: String
    let body: String
    let link: URL?
    let tags: [String]
    let creatorId: String
    let communityId: String
}

struct Post: Identifiable {
    let id: String = UUID().uuidString
    let creationDate: Date
    let title: String
    let body: String
    let link: URL?
    var comments: [Comment]
    var likeCount: Int
    var dislikeCount: Int
    var superLikeCount: Int
    let creator: User
    let community: Community
    var tags: [String]
    
    init(
        creationDate: Date = Date(),
        title: String,
        body: String,
        link: URL?,
        comments: [Comment] = [],
        likeCount: Int = 0,
        dislikeCount: Int = 0,
        superLikeCount: Int = 0,
        creator: User = .preview,
        community: Community = .preview,
        tags: [String]
    ) {
        self.creationDate = creationDate
        self.title = title
        self.body = body
        self.link = link
        self.comments = comments
        self.likeCount = likeCount
        self.dislikeCount = dislikeCount
        self.superLikeCount = superLikeCount
        self.creator = creator
        self.community = community
        self.tags = tags
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
