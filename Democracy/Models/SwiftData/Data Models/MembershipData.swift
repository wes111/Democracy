//
//  MembershipData.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/12/24.
//

import Foundation
import SwiftData

typealias MembershipData = SchemaV1.MembershipData

extension SchemaV1 {
    
    @Model
    final class MembershipData: PersistableData {
        typealias DomainModel = Membership
        
        @Attribute(.unique) let remoteId: String
        var community: CommunityData
        let joinDate: Date
        let userId: String // TODO: We don't need to persist this lol.
        
        init(id: String, joinDate: Date, community: CommunityData, userId: String) {
            self.remoteId = id
            self.joinDate = joinDate
            self.community = community
            self.userId = userId
        }
        
        func update(_ model: Membership) {
            // A Membership cannot be updated currently. But possibly in the future with more fields?
        }
        
        func toMembership() -> Membership {
            Membership(id: remoteId, joinDate: joinDate, community: community.toCommunity(), userId: userId)
        }
    }
}
