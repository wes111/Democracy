//
//  RuleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import Foundation

struct RuleViewModel: Hashable, Identifiable {
    let id: String
    let title: String
    let description: String
    let index: Int
    
    init(
        title: String,
        description: String,
        index: Int
    ) {
        id = title
        self.title = title
        self.description = description
        self.index = index
    }
}
