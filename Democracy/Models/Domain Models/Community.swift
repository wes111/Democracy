//
//  Community.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Foundation

struct Community: Hashable, Identifiable {
    let id: UUID = UUID() // TODO: Change where id is assigned value.
    let name: String
    let foundedDate: Date
}
