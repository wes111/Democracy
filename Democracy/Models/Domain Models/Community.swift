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
    let representatives: [Candidate]
    let rules: [String]
    let resources: [String]
    let postCategories: [String] // Categories defined by community, cannot be enum.
}
