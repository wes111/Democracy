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
            "Resource One",
            "Resource Two",
            "Resource Three",
            "Resource Four",
            "Resource Five",
            "Resource Six",
            "Resource Seven",
            "Resource Eight",
            "Resource Nine",
            "Resource Ten"
        ]
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
                    resources: Community.preview.resources
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
                    resources: Community.preview.resources
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
                    resources: Community.preview.resources
                ))
        }
        return array
    }
    
    static let communityCardTapAction: (Community) -> Void = { _ in
        print("Community Card tapped.")
    }
}
