//
//  Membership.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Foundation
import SharedResourcesClientAndServer
import SwiftData

// The Membership object sent to the Appwrite database.
// Note that id, joinDate, and
struct MembershipCreationRequest: Encodable {
    let community: String // TODO: Is this right?
    let userId: String
    let communityId: String
    
    init(userId: String, communityId: String) {
        self.community = communityId
        self.userId = userId
        self.communityId = communityId
    }
}

// The Membership object received from the Appwrite database.
struct MembershipDTO: Decodable {
    let id: String
    let joinDate: Date
    let community: CommunityDTO
    let userId: String
    
    enum CodingKeys: String, CodingKey {
        case community, userId
        case id = "$id"
        case joinDate = "$createdAt"
    }
    
    func toMembership() -> Membership {
        .init(
            id: id,
            joinDate: joinDate,
            community: community.toCommunity(),
            userId: userId
        )
    }
}

// The domain model.
struct Membership: StringIdentifiable, Hashable, Sendable {
    let id: String
    let joinDate: Date
    let community: Community
    let userId: String
}
