//
//  Resource.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/4/24.
//

import Foundation
import SharedResourcesClientAndServer

// The Resource object received from the Appwrite database.
struct ResourceDTO: Decodable {
    let id: String
    let title: String
    let description: String?
    let link: URL?
    let category: ResourceCategory
    let communityId: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, link, category, communityId
        case id = "$id"
    }
    
    func toResource() -> Resource {
        .init(
            id: id,
            title: title,
            description: description,
            link: link,
            category: category,
            communityId: communityId
        )
    }
}

// Domain Object.
struct Resource: Hashable, Codable, Identifiable {
    let id: String
    let title: String
    let description: String?
    let link: URL?
    let category: ResourceCategory
    let communityId: String
    
    func toCreationRequest() -> ResourceCreationRequest {
        .init(
            title: title,
            description: description,
            link: link,
            category: category.rawValue,
            communityId: communityId
        )
    }
}

// The Resource object sent to the Appwrite database.
// Note that 'id', is not part of this object.
struct ResourceCreationRequest: Encodable {
    let title: String
    let description: String?
    let link: URL?
    let category: String
    let communityId: String
}
