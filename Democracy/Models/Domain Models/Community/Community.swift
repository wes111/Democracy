//
//  Community.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

// SETTINGS:
// 1.) Community Government Type: Autocracy vs Democracy (Is leadership elected or self-appointed?)
// 2.) Community Visibility: Private vs public (who can view posts).
// 3.) Allows adult content.
// 4.) Which users can post? (anyone, leadership, experts/list )
// 5.) Which users can comment (members, anyone)
// 6.) Banned users
// 7.) Submitted post approval process: Requires mod approval or auto-approval

// Notes:
// 1.) A community has leaders. For the first 30? days the creator is the leader and can appoint other
//     leaders. After that time is when the voting starts?


// The Community object sent to the Appwrite database.
// Note that 'id', 'creationDate', 'representatives' are not part of this object.
struct CommunityCreationRequest: Encodable {
    let creatorId: String
    let name: String // This should be the same as id...
    let description: String
    let rules: [RuleCreationRequest]
    let resources: [ResourceCreationRequest]
    let categories: [String]
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case creatorId, name, description, categories, tags
        case rules = "rule"
        case resources = "resource"
    }
}

// The Community object received from the Appwrite database.
struct CommunityDTO: Decodable {
    let id: String
    let creatorId: String
    let name: String
    let description: String
    let creationDateWrapper: DateWrapper
    var representatives: [Candidate]? // TODO: Add as attribute in Appwrite Database.
    let memberCount: Int
    var rules: [RuleDTO]
    var resources: [ResourceDTO]
    var categories: [String]
    var tags: [String]
    var alliedCommunities: [CommunityDTO]? // TODO: Add as attribute in Appwrite Database.
    
    enum CodingKeys: String, CodingKey {
        case creatorId, name, description, representatives, memberCount, categories, tags,
             alliedCommunities
        
        case id = "$id"
        case rules = "rule"
        case resources = "resource"
        case creationDateWrapper = "$createdAt"
    }
    
    func toCommunity() -> Community {
        .init(
            id: id,
            creatorId: creatorId,
            name: name,
            description: description,
            creationDate: creationDateWrapper.date,
            representatives: representatives ?? [],
            memberCount: memberCount,
            rules: rules.map { $0.toRule() },
            resources: resources.map { $0.toResource() },
            categories: categories,
            tags: tags,
            alliedCommunities: alliedCommunities?.compactMap { $0.toCommunity() } ?? []
        )
    }
}

// The domain model.
struct Community: Hashable, Identifiable {
    let id: String
    let creatorId: String
    let name: String
    let description: String
    let creationDate: Date
    var representatives: [Candidate]
    let memberCount: Int
    var rules: [Rule]
    var resources: [Resource]
    var categories: [String]
    var tags: [String]
    var alliedCommunities: [Community]
}
