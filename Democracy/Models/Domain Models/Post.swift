//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation

// The Post object sent to the Appwrite database.
// Note that 'id', 'creationDate', and 'approvedDate' are not part of this object.
struct PostCreationRequest: Encodable {
    let title: String
    let body: String
    let link: String?
    let category: String
    let tags: [String]
    let userId: String
    let communityId: String
    var rootCommentIds: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case title, body, link, category, tags, userId, communityId
        case rootCommentIds = "comment"
    }
}

// The Post object received from the Appwrite database.
struct PostDTO: Decodable {
    let id: String
    let title: String
    let body: String
    let link: URLOptionalWrapper
    let category: String
    let tags: [String]
    let userId: String
    let communityId: String
    let creationDate: DateWrapper
    let rootCommentIds: [String]? // TODO: Add as attribute in Appwrite Database.
    let approvedDate: DateOptionalWrapper
    
    enum CodingKeys: String, CodingKey {
        case title, body, link, category, tags, userId, communityId, approvedDate
        case id = "$id"
        case creationDate = "$createdAt"
        case rootCommentIds = "comment"
    }
    
    func toPost() -> Post {
        .init(
            id: id,
            title: title,
            body: body,
            link: link.url,
            category: category,
            tags: tags,
            userId: userId,
            communityId: communityId,
            creationDate: creationDate.date,
            rootCommentIds: rootCommentIds ?? [],
            approvedDate: approvedDate.date
        )
    }
}

// The domain model.
struct Post: Identifiable, Hashable {
    let id: String
    let title: String
    let body: String
    let link: URL?
    let category: String
    let tags: [String]
    let userId: String
    let communityId: String
    let creationDate: Date
    let rootCommentIds: [String]
    let approvedDate: Date?
}
