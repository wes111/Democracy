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

// MARK: - Data Model
typealias MembershipData = SchemaV1.MembershipData

extension SchemaV1 {
    
    @Model
    final class MembershipData: PersistableData {
        @Attribute(.unique) let remoteId: String
        var community: CommunityData
        let joinDate: Date
        let userId: String
        
        init(id: String, joinDate: Date, community: CommunityData, userId: String) {
            self.remoteId = id
            self.joinDate = joinDate
            self.community = community
            self.userId = userId
        }
        
        func update(_ model: Membership) {
            // A Membership cannot be updated currently. But possibly in the future with more fields?
        }
    }
}

enum DataHandlerError: Error {
    case fetchItemError
    case idNotString
}

protocol DataHandlerProtocol: ModelActor {
    associatedtype DataModel: PersistableData
    
    func deleteItem(model: DataModel.DomainModel) throws
    func updateItem(model: DataModel.DomainModel) throws
    
    @discardableResult func newItem(model: DataModel.DomainModel, shouldSave: Bool) throws -> PersistentIdentifier
    @discardableResult func replaceAll(memberships: [Membership]) async throws -> [PersistentIdentifier]
}

extension DataHandlerProtocol {
    
    func fetchIdentifier(model: DataModel.DomainModel) throws -> PersistentIdentifier {
        guard let id = model.id as? String else {
            throw DataHandlerError.idNotString
        }
        let fetchDescriptor = FetchDescriptor<DataModel>(predicate: #Predicate { $0.remoteId == id })
        guard let item = try modelContext.fetch(fetchDescriptor).first else {
            throw DataHandlerError.fetchItemError
        }
        return item.id
    }
    
    // Fetch all instances of DataModel, with no filtering or sorting applied.
    func fetchAll() throws -> [DataModel] {
        let fetchDescriptor = FetchDescriptor<DataModel>()
        return try modelContext.fetch(fetchDescriptor)
    }
    
    func updateItem(model: DataModel.DomainModel) throws {
        let id = try fetchIdentifier(model: model)
        guard let item = self[id, as: DataModel.self] else {
            return
        }
        item.update(model)
        try modelContext.save()
    }
    
    // Delete the DataModel of the provided DomainModel
    func deleteItem(model: DataModel.DomainModel) throws {
        let id = try fetchIdentifier(model: model)
        guard let item = self[id, as: DataModel.self] else {
            return
        }
        modelContext.delete(item)
        try modelContext.save()
    }
    
    // Delete the PersistableData.
    func deleteItem<T: PersistableData>(model: T) throws {
        modelContext.delete(model)
        try modelContext.save()
    }
}

protocol PersistableData: PersistentModel {
    associatedtype DomainModel: Identifiable
    
    var remoteId: String { get }
    
    func update(_ model: DomainModel)
}

@ModelActor
actor DataHandler: DataHandlerProtocol {
    
    typealias DataModel = MembershipData
    
    @discardableResult
    func replaceAll(memberships: [Membership]) throws -> [PersistentIdentifier] {
        let persistedMemberships = try fetchAll()
        for membership in persistedMemberships {
            let persistedCommunity = membership.community
            try deleteItem(model: membership)
            try deleteItem(model: persistedCommunity)
        }
        var identifiers: [PersistentIdentifier] = []
        for membership in memberships {
            let updatedCommunity = CommunityData(community: membership.community)
            let updatedMembership = MembershipData(
                id: membership.id,
                joinDate: membership.joinDate,
                community: updatedCommunity,
                userId: membership.userId
            )
            identifiers.append(updatedMembership.persistentModelID)
            modelContext.insert(updatedCommunity)
            modelContext.insert(updatedMembership)
        }
        try modelContext.save()
        return identifiers
    }
    
    @discardableResult
    func newItem(model: DataModel.DomainModel, shouldSave: Bool = true) throws -> PersistentIdentifier {
        let dataItem = try membershipData(from: model)
        modelContext.insert(dataItem)
        if shouldSave {
            try modelContext.save()
        }
        return dataItem.persistentModelID
    }
}

// MARK: - Private Methods
private extension DataHandler {
    func communityData(from membership: DataModel.DomainModel) throws -> CommunityData {
        let id = membership.id
        let fetchDescriptor = FetchDescriptor<CommunityData>(predicate: #Predicate { $0.remoteId == id })
        let bob = try modelContext.fetch(fetchDescriptor).first ?? .init(id: membership.community.id)
        print(bob.remoteId)
        return bob
    }
    
    func membershipData(from model: DataModel.DomainModel) throws -> DataModel {
        let communityData = try communityData(from: model)
        return MembershipData(
            id: model.id,
            joinDate: model.joinDate,
            community: communityData,
            userId: model.userId
        )
    }
}
