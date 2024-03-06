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

struct TempCommunity: Codable, Hashable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
    }
}

// The Community object sent to the Appwrite database.
// Note that 'id', 'creationDate', 'representatives' are not part of this object.
struct CommunityDTO: Encodable {
    let creatorId: String
    let name: String // This should be the same as id...
    let description: String
    let rules: [RuleDTO]
    let resources: [ResourceDTO]
    let categories: [String]
    let tags: [String]
    // let alliedCommunities: [Community]
    
    enum CodingKeys: String, CodingKey {
        case creatorId, name, description, categories, tags
        case rules = "rule"
        case resources = "resource"
    }
}

struct Community: Hashable, Identifiable, Codable {
    let id: String
    let creatorId: String
    let name: String
    let description: String
    let creationDate: Date
    var representatives: [Candidate] // TODO: Add as attribute in Appwrite Database.
    let memberCount: Int
    var rules: [Rule]
    var resources: [Resource]
    var categories: [String]
    var tags: [String]
    var alliedCommunities: [Community] // TODO: Add as attribute in Appwrite Database.
    
    init(
        id: String,
        creatorId: String,
        name: String,
        description: String,
        creationDate: Date,
        representatives: [Candidate],
        memberCount: Int,
        rules: [Rule],
        resources: [Resource],
        categories: [String],
        tags: [String],
        alliedCommunities: [Community]
    ) {
        self.id = id
        self.creatorId = creatorId
        self.name = name
        self.description = description
        self.creationDate = creationDate
        self.representatives = representatives
        self.memberCount = memberCount
        self.rules = rules
        self.resources = resources
        self.categories = categories
        self.tags = tags
        self.alliedCommunities = alliedCommunities
    }
    
    enum CodingKeys: String, CodingKey {
        case creatorId, name, description, representatives, memberCount, categories, tags,
             alliedCommunities
        
        case id = "$id"
        case rules = "rule"
        case resources = "resource"
        case creationDate = "$createdAt"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        creatorId = try container.decode(String.self, forKey: .creatorId)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        
        // Parse creationDate as Date
        let dateString = try container.decode(String.self, forKey: .creationDate)
        guard let date = ISO8601DateFormatter.sharedWithFractionalSeconds.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(
                forKey: .creationDate,
                in: container, debugDescription: "Invalid date format"
            )
        }
        creationDate = date
        
        representatives = try container.decodeIfPresent([Candidate].self, forKey: .representatives) ?? []
        memberCount = try container.decode(Int.self, forKey: .memberCount)
        rules = try container.decode([Rule].self, forKey: .rules)
        resources = try container.decode([Resource].self, forKey: .resources)
        categories = try container.decode([String].self, forKey: .categories)
        tags = try container.decode([String].self, forKey: .tags)
        alliedCommunities = try container.decodeIfPresent([Community].self, forKey: .alliedCommunities) ?? []
    }
}

struct GARBAGERule: Codable, Hashable {
    let id: String
    let title: String
    let description: String
    
    func viewModel(index: Int) -> RuleViewModel {
        .init(
            title: title,
            description: description,
            index: index
        )
    }
}
