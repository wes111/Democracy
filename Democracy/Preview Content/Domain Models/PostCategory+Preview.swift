//
//  PostCategory+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/13/24.
//

import Foundation

extension PostCategory {
    static let preview = PostCategory(
        id: UUID().uuidString,
        name: "Black Krim",
        imageUrl: nil,
        postCount: 11,
        communityId: "Test",
        creationDate: .now
    )
    
    static let previewArray: [PostCategory] = [
        PostCategory(
            id: UUID().uuidString,
            name: "Black Krim",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        ),
        PostCategory(
            id: UUID().uuidString,
            name: "Kellog's Breakfast",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        ),
        PostCategory(
            id: UUID().uuidString,
            name: "BrandyWine",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        ),
        PostCategory(
            id: UUID().uuidString,
            name: "Sun Sugar",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        ),
        PostCategory(
            id: UUID().uuidString,
            name: "Super Sweet 100",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        ),
        PostCategory(
            id: UUID().uuidString,
            name: "Better Boy",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        ),
        PostCategory(
            id: UUID().uuidString,
            name: "Celebrity",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        ),
        PostCategory(
            id: UUID().uuidString,
            name: "Opalka",
            imageUrl: nil,
            postCount: 11,
            communityId: "Test",
            creationDate: .now
        )
    ]
}
