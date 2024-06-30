//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation
import SharedResourcesClientAndServer

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
    
    enum CodingKeys: String, CodingKey {
        case title, body, link, category, tags, userId, communityId
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
            approvedDate: approvedDate
        )
    }
}

// The domain model.
struct Post: Identifiable, Hashable { //}, Votable {
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
}
