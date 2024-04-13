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
    func replaceAll(newMemberships: [Membership]) throws -> [PersistentIdentifier] {
        // TODO: We might want to delete the CommunityData too (prevent unnecessary community storage)
        try modelContext.delete(model: MembershipData.self)
        var identifiers: [PersistentIdentifier] = []
        for membership in newMemberships {
            let persistentId = try insertNewMembershipData(domainModel: membership, shouldSave: false)
            identifiers.append(persistentId)
        }
        try modelContext.save()
        return identifiers
    }
    
    func fetchPersistedMemberships() throws -> [Membership] {
        try fetchAll().map { $0.toMembership() }
    }
    
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
    
    func newDelete(model: Membership) throws {
        guard let dataModel = try newFetch(for: model) else {
            return
        }
        modelContext.delete(dataModel)
        try modelContext.save()
    }
}

private extension MembershipDataHandler {
    
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
        CommunityData(
            remoteId: model.id,
            creatorId: model.creatorId,
            name: model.name,
            descriptionText: model.descriptionText,
            creationDate: model.creationDate,
            // representatives: model.representatives,
            memberCount: model.memberCount,
            rules: model.rules,
            resources: model.resources,
            categories: model.categories,
            tags: model.tags,
            // alliedCommunities: model.alliedCommunities,
            governmentType: model.governmentType,
            contentType: model.contentType,
            visibilityType: model.visibilityType,
            allowedPosterType: model.allowedPosterType,
            allowedCommenterType: model.allowedCommenterType,
            postApprovalType: model.postApprovalType
        )
    }
    
    func newFetch(for model: Membership) throws -> MembershipData? {
        let id = model.id
        let fetchDescriptor = FetchDescriptor<MembershipData>(predicate: #Predicate { $0.remoteId == id })
        return try modelContext.fetch(fetchDescriptor).first
    }
}
