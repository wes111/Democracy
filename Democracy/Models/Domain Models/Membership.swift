//
//  Membership.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Foundation

// The Membership object received from the Appwrite database.
struct MembershipDTO: Decodable {
    let id: String
    let joinDate: DateWrapper
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
            joinDate: joinDate.date,
            community: community.toCommunity(),
            userId: userId
        )
    }
}

// The domain model.
struct Membership: Identifiable, Hashable, Sendable {
    let id: String
    let joinDate: Date
    let community: Community
    let userId: String
}
