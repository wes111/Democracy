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
        creatorId: UUID().uuidString,
        name: "Test Community",
        description: """
                 Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah,
                 blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                 blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                 blah, blah, blah
                 """,
        creationDate: Date(),
        representatives: Candidate.representativePreviewArray,
        memberCount: 255,
        rules: Rule.previewArray,
        resources: Resource.previewArray,
        categories: ["Racing", "Sports", "Weather", "Dog Grooming", "Vampires", "Fruit & Veggies"],
        tags: [
            "Rudy",
            "Nicole",
            "Wesley",
            "Nascar",
            "Denny Hamlin",
            "Global Warming",
            "Contigo",
            "Annoying Dog",
            "TV",
            "Jackson",
            "Miley",
            "Hannah Montana",
            "Sun Glasses",
            "Rudy",
            "Nicole",
            "Wesley",
            "Nascar",
            "Denny Hamlin",
            "Global Warming",
            "Contigo",
            "Annoying Dog",
            "TV",
            "Jackson",
            "Miley",
            "Hannah Montana",
            "Sun Glasses",
            "Rudy",
            "Nicole",
            "Wesley",
            "Nascar",
            "Denny Hamlin",
            "Global Warming",
            "Contigo",
            "Annoying Dog",
            "TV",
            "Jackson",
            "Miley",
            "Hannah Montana",
            "Sun Glasses",
            "Rudy",
            "Nicole",
            "Wesley",
            "Nascar",
            "Denny Hamlin",
            "Global Warming",
            "Contigo",
            "Annoying Dog",
            "TV",
            "Jackson",
            "Miley",
            "Hannah Montana",
            "Sun Glasses",
            "Rudy",
            "Nicole",
            "Wesley",
            "Nascar",
            "Denny Hamlin",
            "Global Warming",
            "Contigo",
            "Annoying Dog",
            "TV",
            "Jackson",
            "Miley",
            "Hannah Montana",
            "Sun Glasses",
            "Rudy",
            "Nicole",
            "Wesley",
            "Nascar",
            "Denny Hamlin",
            "Global Warming",
            "Contigo",
            "Annoying Dog",
            "TV",
            "Jackson",
            "Miley",
            "Hannah Montana",
            "Sun Glasses"
        ],
        alliedCommunities: []
    )
    
    static var myCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(
                Community(
                    id: UUID().uuidString,
                    creatorId: UUID().uuidString,
                    name: "My Community \(index)",
                    description: """
                             Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah,
                             blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                             blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                             blah, blah, blah
                             """,
                    creationDate: Community.preview.creationDate,
                    representatives: Community.preview.representatives,
                    memberCount: 255,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    categories: ["Racing", "Sports", "Weather",
                                 "Dog Grooming", "Vampires", "Fruit & Veggies"],
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
                    creatorId: UUID().uuidString,
                    name: "Recommended Community \(index)",
                    description: """
                             Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah,
                             blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                             blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                             blah, blah, blah
                             """,
                    creationDate: Community.preview.creationDate,
                    representatives: Community.preview.representatives,
                    memberCount: 255,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    categories: ["Racing", "Sports", "Weather",
                                 "Dog Grooming", "Vampires", "Fruit & Veggies"],
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
                    creatorId: UUID().uuidString,
                    name: "Top Community \(index)",
                    description: """
                             Welcome to the Community, blah, blah, blah Welcome to the Community, blah, blah, 
                             blah Welcome to the Community, blah, blah, blah Welcome to the Community, blah,
                             blah, blah Welcome to the Community, blah, blah, blah Welcome to the Community,
                             blah, blah, blah
                             """,
                    creationDate: Community.preview.creationDate,
                    representatives: Community.preview.representatives,
                    memberCount: 255,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    categories: ["Racing", "Sports", "Weather", "Dog Grooming", "Vampires", "Fruit & Veggies"],
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
