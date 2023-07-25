//
//  Community.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

struct Community: Hashable, Identifiable, Codable {
    let id: UUID // TODO: Change where id is assigned value.
    let name: String
    let summary: String
    let foundedDate: Date
    var representatives: [Candidate]
    let memberCount: Int
    var rules: [Rule]
    var resources: [Resource]
    var postCategories: [CommunityCategory] // Categories defined by community, cannot be enum.
    var alliedCommunities: [Community]
}

struct Rule: Codable, Hashable {
    let id: UUID
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

struct Resource: Codable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let url: URL
    
    func viewModel(index: Int) -> ResourceViewModel {
        .init(
            title: title,
            description: description,
            index: index,
            url: url
        )
    }
}
