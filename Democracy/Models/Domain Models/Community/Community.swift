//
//  Community.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation
import SharedResourcesClientAndServer
import SwiftData

// The domain model.
struct Community: StringIdentifiable, Hashable, Sendable {
    let id: String
    let creatorId: String
    let name: String
    let descriptionText: String
    let creationDate: Date
    // var representatives: [Candidate]
    let memberCount: Int
    var rules: [Rule]
    var resources: [Resource]
    var categories: [PostCategory]
    var tags: [String]
    var tagline: String
    var settings: CommunitySettings
    // var alliedCommunities: [Community]
}
extension CommunityDTO {
    func toCommunity() -> Community {
        .init(
            id: id,
            creatorId: creatorId,
            name: name,
            descriptionText: descriptionText,
            creationDate: creationDate,
            // representatives: representatives ?? [],
            memberCount: memberCount,
            rules: rules.map { $0.toRule() },
            resources: resources.map { $0.toResource() },
            categories: postCategories.map { $0.toPostCategory() },
            tags: tags,
            tagline: tagline,
            settings: settings.toCommunitySettings()
            // alliedCommunities: alliedCommunities?.compactMap { $0.toCommunity() } ?? [],
        )
    }
}

// MARK: - Data model

typealias CommunityData = SchemaV1.CommunityData

extension SchemaV1 {
    @Model
    final class CommunityData: PersistableData {
        // swiftlint:disable:next nesting
        typealias DomainModel = Community
        
        @Attribute(.unique) let remoteId: String
        
        @Relationship(deleteRule: .cascade, inverse: \MembershipData.community)
        var membership: MembershipData?
        
        let creatorId: String
        var name: String
        var descriptionText: String
        let creationDate: Date
        // var representatives: [Candidate]
        var memberCount: Int
        var rules: [Rule]
        var resources: [Resource]
        var categories: [PostCategory]
        var tags: [String]
        var tagline: String
        var settings: CommunitySettings
        // var alliedCommunities: [CommunityData]
        
        init(
            remoteId: String,
            membership: MembershipData? = nil,
            creatorId: String,
            name: String,
            descriptionText: String,
            creationDate: Date,
            // representatives: [Candidate],
            memberCount: Int,
            rules: [Rule],
            resources: [Resource],
            categories: [PostCategory],
            tags: [String],
            tagline: String,
            // alliedCommunities: [CommunityData],
            settings: CommunitySettings
        ) {
            self.remoteId = remoteId
            self.membership = membership
            self.creatorId = creatorId
            self.name = name
            self.descriptionText = descriptionText
            self.creationDate = creationDate
            // self.representatives = representatives
            self.memberCount = memberCount
            self.rules = rules
            self.resources = resources
            self.categories = categories
            self.tags = tags
            self.tagline = tagline
            // self.alliedCommunities = alliedCommunities
            self.settings = settings
        }
        
        func toCommunity() -> Community {
            Community(
                id: remoteId,
                creatorId: creatorId,
                name: name,
                descriptionText: descriptionText,
                creationDate: creationDate,
                // representatives: representatives,
                memberCount: memberCount,
                rules: rules,
                resources: resources,
                categories: categories,
                tags: tags,
                tagline: tagline,
                settings: settings
                // alliedCommunities: alliedCommunities.map { $0.toCommunity() },
            )
        }
    }
}
