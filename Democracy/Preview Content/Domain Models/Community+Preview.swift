//
//  Community+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

extension Community {
    static let preview = Community(
        id: UUID(),
        name: "Test Community",
        foundedDate: Date(),
        representatives: Candidate.representativePreviewArray,
        rules: [
            "Do not violate the rules.",
            "Do not speak about the rules.",
            "Do not take the rules lightly.",
            "Read all of the rules.",
            "There are no rules."
        ],
        resources: [
            "https://www.google.com",
            "https://www.amazon.com",
            "https://www.walmart.com",
            "https://www.apple.com",
            "https://www.google.com",
            "https://www.google.com",
            "https://www.google.com",
            "https://www.google.com",
            "https://www.google.com",
            "https://www.google.com"
        ],
        postCategories: CommunityCategory.previewArray
    )
    
    static var myCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(
                Community(
                    id: UUID(),
                    name: "My Community \(index)",
                    foundedDate: Community.preview.foundedDate,
                    representatives: Community.preview.representatives,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    postCategories: CommunityCategory.previewArray
                ))
        }
        return array
    }
    
    static var recommendedCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(
                Community(
                    id: UUID(),
                    name: "Recommended Community \(index)",
                    foundedDate: Community.preview.foundedDate,
                    representatives: Community.preview.representatives,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    postCategories: CommunityCategory.previewArray
                ))
        }
        return array
    }
    
    static var topCommunitiesPreviewArray: [Community] {
        var array: [Community] = []
        for index in 0...25 {
            array.append(
                Community(
                    id: UUID(),
                    name: "Top Community \(index)",
                    foundedDate: Community.preview.foundedDate,
                    representatives: Community.preview.representatives,
                    rules: Community.preview.rules,
                    resources: Community.preview.resources,
                    postCategories: CommunityCategory.previewArray
                ))
        }
        return array
    }
    
    static let communityCardTapAction: (Community) -> Void = { _ in
        print("Community Card tapped.")
    }
}
