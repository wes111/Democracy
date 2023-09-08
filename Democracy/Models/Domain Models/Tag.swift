//
//  Tag.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

struct Tag: Hashable, Identifiable, Codable {
    let id: UUID = UUID()
    let name: String
}
