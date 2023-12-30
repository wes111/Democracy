//
//  Community+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

extension Community {
    static let preview = Community(
        id: UUID().uuidString,
        name: "Test Community",
        summary: """
                 Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah,
                 blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                 blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                 blah, blah, blah
                 """,
        foundedDate: Date(),
        representatives: Candidate.representativePreviewArray,
        memberCount: 255,
        rules: Rule.previewArray,
        resources: Resource.previewArray,
        postCategories: CommunityCategory.previewArray, 
        tags: [
            .init(name: "Rudy"),
            .init(name: "Nicole"),
            .init(name: "Wesley"),
            .init(name: "Nascar"),
            .init(name: "Denny Hamlin"),
            .init(name: "Global Warming"),
            .init(name: "Contigo"),
            .init(name: "Annoying Dog"),
            .init(name: "TV"),
            .init(name: "Jackson"),
            .init(name: "Miley"),
            .init(name: "Hannah Montana"),
            .init(name: "Sun Glasses"),
            .init(name: "Rudy"),
            .init(name: "Nicole"),
            .init(name: "Wesley"),
            .init(name: "Nascar"),
            .init(name: "Denny Hamlin"),
            .init(name: "Global Warming"),
            .init(name: "Contigo"),
            .init(name: "Annoying Dog"),
            .init(name: "TV"),
            .init(name: "Jackson"),
            .init(name: "Miley"),
            .init(name: "Hannah Montana"),
            .init(name: "Sun Glasses"),
            .init(name: "Rudy"),
            .init(name: "Nicole"),
            .init(name: "Wesley"),
            .init(name: "Nascar"),
            .init(name: "Denny Hamlin"),
            .init(name: "Global Warming"),
            .init(name: "Contigo"),
            .init(name: "Annoying Dog"),
            .init(name: "TV"),
            .init(name: "Jackson"),
            .init(name: "Miley"),
            .init(name: "Hannah Montana"),
            .init(name: "Sun Glasses"),
            .init(name: "Rudy"),
            .init(name: "Nicole"),
            .init(name: "Wesley"),
            .init(name: "Nascar"),
            .init(name: "Denny Hamlin"),
            .init(name: "Global Warming"),
            .init(name: "Contigo"),
            .init(name: "Annoying Dog"),
            .init(name: "TV"),
            .init(name: "Jackson"),
            .init(name: "Miley"),
            .init(name: "Hannah Montana"),
            .init(name: "Sun Glasses"),
            .init(name: "Rudy"),
            .init(name: "Nicole"),
            .init(name: "Wesley"),
            .init(name: "Nascar"),
            .init(name: "Denny Hamlin"),
            .init(name: "Global Warming"),
            .init(name: "Contigo"),
            .init(name: "Annoying Dog"),
            .init(name: "TV"),
            .init(name: "Jackson"),
            .init(name: "Miley"),
            .init(name: "Hannah Montana"),
            .init(name: "Sun Glasses"),
            .init(name: "Rudy"),
            .init(name: "Nicole"),
            .init(name: "Wesley"),
            .init(name: "Nascar"),
            .init(name: "Denny Hamlin"),
            .init(name: "Global Warming"),
            .init(name: "Contigo"),
            .init(name: "Annoying Dog"),
            .init(name: "TV"),
            .init(name: "Jackson"),
            .init(name: "Miley"),
            .init(name: "Hannah Montana"),
            .init(name: "Sun Glasses")
        ],
        alliedCommunities: []
    )
    
    static var myCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(
                Community(
                    id: UUID().uuidString,
                    name: "My Community \(index)",
                    summary: """
                             Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah,
                             blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                             blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                             blah, blah, blah
                             """,
                    foundedDate: Community.preview.foundedDate,
                    representatives: Community.preview.representatives,
                    memberCount: 255,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    postCategories: CommunityCategory.previewArray, 
                    tags: [],
                    alliedCommunities: []
                ))
        }
        return array
    }
    
    static var recommendedCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(
                Community(
                    id: UUID().uuidString,
                    name: "Recommended Community \(index)",
                    summary: """
                             Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah,
                             blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                             blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                             blah, blah, blah
                             """,
                    foundedDate: Community.preview.foundedDate,
                    representatives: Community.preview.representatives,
                    memberCount: 255,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    postCategories: CommunityCategory.previewArray,
                    tags: [],
                    alliedCommunities: []
                ))
        }
        return array
    }

    static var topCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(
                Community(
                    id: UUID().uuidString,
                    name: "Top Community \(index)",
                    summary: """
                             Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah, 
                             blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                             blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                             blah, blah, blah
                             """,
                    foundedDate: Community.preview.foundedDate,
                    representatives: Community.preview.representatives,
                    memberCount: 255,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    postCategories: CommunityCategory.previewArray,
                    tags: [],
                    alliedCommunities: []
                ))
        }
        return array
    }

    static let communityCardTapAction: (Community) -> Void = { _ in
        print("Community Card tapped.")
    }
}
