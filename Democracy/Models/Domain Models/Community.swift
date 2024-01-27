//
//  Community.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

struct TempCommunity: Codable, Hashable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
    }
}

struct Community: Hashable, Identifiable, Codable {
    let id: String // TODO: Change where id is assigned value.
    let name: String
    let summary: String
    let foundedDate: Date
    var representatives: [Candidate]
    let memberCount: Int
    var rules: [GARBAGERule]
    var resources: [Resource]
    var categories: [String]// Categories defined by community, cannot be enum.
    var tags: [String]
    var alliedCommunities: [Community]
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

struct Resource: Codable, Hashable {
    let id: String
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
