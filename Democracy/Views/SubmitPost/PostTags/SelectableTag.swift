//
//  SelectableTag.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

struct SelectableTag: Identifiable {
    let tag: Tag
    var isSelected: Bool
    let id: String
    
    init(tag: Tag, isSelected: Bool = false) {
        self.tag = tag
        self.isSelected = isSelected
        id = tag.id
    }
}
