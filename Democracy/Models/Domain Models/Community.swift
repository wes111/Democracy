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
    let foundedDate: Date
    var representatives: [Candidate]
    var rules: [String]
    var resources: [String]
    var postCategories: [CommunityCategory] // Categories defined by community, cannot be enum.
}
