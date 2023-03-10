//
//  Comment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

// Structs cannot have a property of the same type.
class Comment: Hashable {
    
    let id: UUID = UUID()
    let parent: Comment? = nil
    let children: [Comment] = []
    
    init() {
        
    }
    
}
