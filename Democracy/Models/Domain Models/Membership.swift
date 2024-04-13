//
//  Membership.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/24/24.
//

import Foundation
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

enum DataHandlerError: Error {
    case fetchItemError
}

protocol DataHandlerProtocol: ModelActor {
    associatedtype DataModel: PersistableData
    typealias DomainModel = DataModel.DomainModel
    
    func deleteItem(model: DomainModel) throws
    func updateItem(model: DomainModel) throws
    
    @discardableResult
    func newDataModel(domainModel: DomainModel, shouldSave: Bool) throws -> PersistentIdentifier
    
    @discardableResult
    func replaceAll(memberships: [DomainModel]) async throws -> [PersistentIdentifier]
}

extension DataHandlerProtocol {
    
    func fetchDataModel(for model: DomainModel) throws -> DataModel? {
        let id = model.id
        let fetchDescriptor = FetchDescriptor<DataModel>(predicate: #Predicate { $0.remoteId == id })
        return try modelContext.fetch(fetchDescriptor).first
    }
    
    // Fetch all instances of DataModel, with no filtering or sorting applied.
    func fetchAll() throws -> [DataModel] {
        let fetchDescriptor = FetchDescriptor<DataModel>()
        return try modelContext.fetch(fetchDescriptor)
    }
    
    func updateItem(model: DomainModel) throws {
        guard let dataModel = try fetchDataModel(for: model) else {
            return
        }
        dataModel.update(model)
        try modelContext.save()
    }
    
    // Delete the DataModel of the provided DomainModel
    func deleteItem(model: DomainModel) throws {
        guard let dataModel = try fetchDataModel(for: model) else {
            return
        }
        modelContext.delete(dataModel)
        try modelContext.save()
    }
}

protocol PersistableData: PersistentModel where DomainModel: Identifiable, DomainModel.ID == String {
    associatedtype DomainModel: Identifiable
    
    var remoteId: String { get }
    
    func update(_ model: DomainModel)
}

@ModelActor
actor DataHandler: DataHandlerProtocol {
    
    typealias DataModel = MembershipData
    typealias DomainModel = DataModel.DomainModel
    
    @discardableResult
    func replaceAll(memberships: [DomainModel]) throws -> [PersistentIdentifier] {
        try modelContext.delete(model: DataModel.self)
        var identifiers: [PersistentIdentifier] = []
        for membership in memberships {
            let persistentId = try newDataModel(domainModel: membership, shouldSave: false)
            identifiers.append(persistentId)
        }
        try modelContext.save()
        return identifiers
    }
    
    @discardableResult
    func newDataModel(domainModel: DomainModel, shouldSave: Bool = true) throws -> PersistentIdentifier {
        let fetchedCommunity = try fetchCommunityData(for: domainModel)
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
}

private extension DataHandler {
    
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
