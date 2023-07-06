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
        rules: Rule.previewArray,
        resources: Resource.previewArray,
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
