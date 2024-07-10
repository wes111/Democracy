//
//  Rule.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/27/24.
//

import Foundation

// The Rule object received from the Appwrite database.
// In Appwrite, a Rule has a 1-way relationship with Community.
struct RuleDTO: Decodable {
    let id: String
    let title: String
    let description: String
    let communityId: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, communityId
        case id = "$id"
    }
    
    func toRule() -> Rule {
        .init(
            id: id,
            title: title,
            description: description,
            communityId: communityId
        )
    }
}

struct Rule: Equatable, Hashable, Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let communityId: String
    
    func toCreationRequest() -> RuleCreationRequest {
        .init(communityId: communityId, title: title, description: description)
    }
}

// The Rule object sent to the Appwrite database.
// Note that 'id', is not part of this object.
struct RuleCreationRequest: Encodable {
    let communityId: String
    let title: String
    let description: String
}
