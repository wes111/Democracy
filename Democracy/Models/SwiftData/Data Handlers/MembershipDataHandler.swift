//
//  MembershipDataHandler.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/12/24.
//

import Foundation
import SwiftData

@ModelActor
actor MembershipDataHandler: DataHandler {
    typealias DataModel = MembershipData
    
    @discardableResult
    func replaceAll(memberships: [Membership]) throws -> [PersistentIdentifier] {
        try modelContext.delete(model: MembershipData.self)
        var identifiers: [PersistentIdentifier] = []
        for membership in memberships {
            let persistentId = try insertNewMembershipData(domainModel: membership, shouldSave: false)
            identifiers.append(persistentId)
        }
        try modelContext.save()
        return identifiers
    }
}

private extension MembershipDataHandler {
    
    @discardableResult
    func insertNewMembershipData(domainModel: DomainModel, shouldSave: Bool = true)
    throws -> PersistentIdentifier {
        let fetchedCommunity: CommunityData? = try fetchCommunityData(for: domainModel)
        let communityData = fetchedCommunity ?? communityData(from: domainModel.community)
        let membershipData = membershipData(from: domainModel, communityData: communityData)
        if fetchedCommunity == nil {
            modelContext.insert(communityData)
        }
        modelContext.insert(membershipData)
        if shouldSave {
            try modelContext.save()
        }
        return membershipData.persistentModelID
    }
    
    func fetchCommunityData(for membership: Membership) throws -> CommunityData? {
        let id = membership.community.id
        let fetchDescriptor = FetchDescriptor<CommunityData>(predicate: #Predicate { $0.remoteId == id })
        return try modelContext.fetch(fetchDescriptor).first
    }
    
    func membershipData(from model: Membership, communityData: CommunityData) -> MembershipData {
        MembershipData(
            id: model.id,
            joinDate: model.joinDate,
            community: communityData,
            userId: model.userId
        )
    }
    
    func communityData(from model: Community) -> CommunityData {
        CommunityData(id: model.id)
    }
}

