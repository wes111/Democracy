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
struct PostDTO: Encodable {
    let title: String
    let body: String
    let link: String?
    let tags: [String]
    let userId: String
    let communityId: String
    var rootCommentIds: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case title, body, link, tags, userId
        case communityId = "community"
        case rootCommentIds = "comment"
    }
}

// The domain model and the object received from the Appwrite database.
struct Post: Identifiable, Hashable {
    let id: String
    let title: String
    let body: String
    let link: URL?
    let tags: [String]
    let userId: String
    let community: TempCommunity
    let creationDate: Date
    let rootCommentIds: [String] // <-- TODO: ...
    let approvedDate: Date?
    
    // TODO: Remove
    func toViewModel(coordinator: PostCardCoordinatorDelegate?) -> PostCardViewModel {
        .init(coordinator: coordinator, post: self)
    }
}

extension Post: Codable {
    enum CodingKeys: String, CodingKey {
        case title, body, link, tags, userId, community, approvedDate
        case id = "$id"
        case creationDate = "$createdAt"
        case rootCommentIds = "comment"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatError = DecodingError.dataCorruptedError(
            forKey: .creationDate,
            in: container,
            debugDescription: "Invalid date format")
        
        // Standard decoding
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        tags = try container.decode([String].self, forKey: .tags)
        userId = try container.decode(String.self, forKey: .userId)
        community = try container.decode(TempCommunity.self, forKey: .community)
        rootCommentIds = try container.decode([String].self, forKey: .rootCommentIds)
        
        // Decode 'link'
        let linkString = try container.decode(String.self, forKey: .link)
        guard let link = URL(string: linkString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .link,
                in: container,
                debugDescription: "Invalid link format"
            )
        }
        self.link = link
        
        // Decode 'creationDate'
        let dateString = try container.decode(String.self, forKey: .creationDate)
        guard let creationDate =
                ISO8601DateFormatter.sharedWithFractionalSeconds.date(from: dateString) else
        {
            throw dateFormatError
        }
        self.creationDate = creationDate
        
        // Decode 'approvedDate'
        if let approvedDateString = try container.decodeIfPresent(String.self, forKey: .approvedDate) {
            guard let approvedDate =
                    ISO8601DateFormatter.sharedWithFractionalSeconds.date(from: dateString) else
            {
                throw dateFormatError
            }
            self.approvedDate = approvedDate
        } else {
            self.approvedDate = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        // Standard encoding
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(tags, forKey: .tags)
        try container.encode(userId, forKey: .userId)
        try container.encode(community, forKey: .community)
        try container.encode(rootCommentIds, forKey: .rootCommentIds)

        // Encode 'link'
        if let link {
            try container.encode(link.absoluteString, forKey: .link)
        }

        // Encode 'creationDate'
        let dateString = ISO8601DateFormatter.sharedWithFractionalSeconds.string(from: creationDate)
        try container.encode(dateString, forKey: .creationDate)
        
        // Encode 'approvedDate'
        if let approvedDate {
            let dateString = ISO8601DateFormatter.sharedWithFractionalSeconds.string(from: approvedDate)
            try container.encode(dateString, forKey: .approvedDate)
        }
    }
}
