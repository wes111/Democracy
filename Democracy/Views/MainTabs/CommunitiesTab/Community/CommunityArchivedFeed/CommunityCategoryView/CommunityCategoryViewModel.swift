//
//  CommunityCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/26/23.
//

import Foundation

struct CommunityCategoryViewModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let imageName: String
    var postCount: Int
}
