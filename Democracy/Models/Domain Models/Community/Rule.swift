//
//  Rule.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/27/24.
//

import Foundation

// In Appwrite, a Rule has a 1-way relationship with Community.
struct Rule: Equatable, Hashable, Codable {
    let id: String
    let title: String
    let description: String
    let communityId: String
    
    enum CodingKeys: String, CodingKey {
        case title, description, communityId
        
        case id = "$id"
    }
    
    func toDTO() -> RuleDTO {
        .init(communityId: communityId, title: title, description: description)
    }
}

// The Rule object sent to the Appwrite database.
// Note that 'id', is not part of this object.
// Note that 'communityId', IS a part of this object.
struct RuleDTO: Encodable {
    let communityId: String
    let title: String
    let description: String
}
