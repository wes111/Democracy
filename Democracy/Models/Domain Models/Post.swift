//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation

struct Post: Hashable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let body: String
}
