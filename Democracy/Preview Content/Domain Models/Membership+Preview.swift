//
//  Membership+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation

extension Membership {
    
    static var preview: Membership {
        .init(
            id: UUID().uuidString,
            joinDate: .now,
            community: .preview,
            userId: "123"
        )
    }
}
