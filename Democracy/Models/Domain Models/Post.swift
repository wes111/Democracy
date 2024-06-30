//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation
import SharedResourcesClientAndServer

// The domain model.
@Observable
final class Post: Identifiable, Hashable, Votable {
    let id: String
    let title: String
    let body: String
    let link: URL?
    let category: String
    let tags: [String]
    let userId: String
    let communityId: String
    let creationDate: Date
    let approvedDate: Date?
    var upVoteCount: Int
    var downVoteCount: Int
    var userVote: PostVote?
    
    init(
        id: String,
        title: String,
        body: String,
        link: URL?,
        category: String,
        tags: [String],
        userId: String,
        communityId: String,
        creationDate: Date,
        approvedDate: Date?,
        upVoteCount: Int,
        downVoteCount: Int
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.link = link
        self.category = category
        self.tags = tags
        self.userId = userId
        self.communityId = communityId
        self.creationDate = creationDate
        self.approvedDate = approvedDate
        self.upVoteCount = upVoteCount
        self.downVoteCount = downVoteCount
    }
}

extension PostDTO {
    func toPost() -> Post {
        .init(
            id: id,
            title: title,
            body: body,
            link: link,
            category: category,
            tags: tags,
            userId: userId,
            communityId: communityId,
            creationDate: creationDate,
            approvedDate: approvedDate,
            upVoteCount: upVoteCount,
            downVoteCount: downVoteCount
        )
    }
}
