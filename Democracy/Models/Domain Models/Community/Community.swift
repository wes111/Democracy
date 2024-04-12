//
//  Community.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation
import SwiftData

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
    let name: String // Name is the same as Id.
    let descriptionText: String
    let rules: [RuleCreationRequest]
    let resources: [ResourceCreationRequest]
    let categories: [String]
    let tags: [String]
    
    // Settings:
    var governmentType: CommunityGovernment
    var contentType: CommunityContent
    var visibilityType: CommunityVisibility
    var allowedPosterType: CommunityPoster
    var allowedCommenterType: CommunityCommenter
    var postApprovalType: CommunityPostApproval
    
    enum CodingKeys: String, CodingKey {
        case creatorId, name, categories, tags, governmentType, contentType, visibilityType,
             allowedPosterType, allowedCommenterType, postApprovalType
        
        case rules = "rule"
        case resources = "resource"
        case descriptionText = "description"
    }
}

// The Community object received from the Appwrite database.
struct CommunityDTO: Decodable {
    let id: String
    let creatorId: String
    let name: String
    let descriptionText: String
    let creationDateWrapper: DateWrapper
    var representatives: [Candidate]? // TODO: Add as attribute in Appwrite Database.
    let memberCount: Int
    var rules: [RuleDTO]
    var resources: [ResourceDTO]
    var categories: [String]
    var tags: [String]
    var alliedCommunities: [CommunityDTO]? // TODO: Add as attribute in Appwrite Database.
    
    // Settings:
    var governmentType: CommunityGovernment
    var contentType: CommunityContent
    var visibilityType: CommunityVisibility
    var allowedPosterType: CommunityPoster
    var allowedCommenterType: CommunityCommenter
    var postApprovalType: CommunityPostApproval
    
    enum CodingKeys: String, CodingKey {
        case creatorId, name, representatives, memberCount, categories, tags,
             alliedCommunities, governmentType, contentType, visibilityType, allowedPosterType,
             allowedCommenterType, postApprovalType
        
        case id = "$id"
        case rules = "rule"
        case resources = "resource"
        case creationDateWrapper = "$createdAt"
        case descriptionText = "description"
    }
    
    func toCommunity() -> Community {
        .init(
            id: id,
            creatorId: creatorId,
            name: name,
            descriptionText: descriptionText,
            creationDate: creationDateWrapper.date,
            representatives: representatives ?? [],
            memberCount: memberCount,
            rules: rules.map { $0.toRule() },
            resources: resources.map { $0.toResource() },
            categories: categories,
            tags: tags,
            alliedCommunities: alliedCommunities?.compactMap { $0.toCommunity() } ?? [],
            governmentType: governmentType,
            contentType: contentType,
            visibilityType: visibilityType,
            allowedPosterType: allowedPosterType,
            allowedCommenterType: allowedCommenterType,
            postApprovalType: postApprovalType
        )
    }
}

// The domain model.
struct Community: Identifiable, Hashable, Sendable {
    let id: String
    let creatorId: String
    let name: String
    let descriptionText: String
    let creationDate: Date
    var representatives: [Candidate]
    let memberCount: Int
    var rules: [Rule]
    var resources: [Resource]
    var categories: [String]
    var tags: [String]
    var alliedCommunities: [Community]
    
    // Settings:
    var governmentType: CommunityGovernment
    var contentType: CommunityContent
    var visibilityType: CommunityVisibility
    var allowedPosterType: CommunityPoster
    var allowedCommenterType: CommunityCommenter
    var postApprovalType: CommunityPostApproval
}

// MARK: - Data model

typealias CommunityData = SchemaV1.CommunityData

extension SchemaV1 {
    @Model
    final class CommunityData: PersistableData {
        @Attribute(.unique) let remoteId: String // Seems to be preventing adding memberships... hmm...
        @Relationship(deleteRule: .cascade, inverse: \MembershipData.community)
        var membership: MembershipData?
        
        init(id: String) {
            remoteId = id
        }
        
        init(community: Community) {
            self.remoteId = community.id
        }
        
        func update(_ model: Community) {
            // Nothing to update yet...
        }
    }
}
