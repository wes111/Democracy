//
//  PostVote+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation

extension PostVote {
    
    static var preview: PostVote {
        .init(
            id: UUID().uuidString,
            creationDate: .now,
            itemId: "",
            userId: "123"
        )
    }
}
