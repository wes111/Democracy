//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation
import SharedResourcesClientAndServer

extension CommunityTag {
    static var previewArray: [CommunityTag] {
        [
            .init(id: "", communityId: "", name: "Dog", creationDate: .now),
            .init(id: "", communityId: "", name: "Chicken", creationDate: .now),
            .init(id: "", communityId: "", name: "Cat", creationDate: .now),
            .init(id: "", communityId: "", name: "Elephant", creationDate: .now),
            .init(id: "", communityId: "", name: "Zebra", creationDate: .now),
            .init(id: "", communityId: "", name: "Mouse", creationDate: .now),
        ]
    }
}

extension Post {
    
    static var preview: Post {
        Post(
            id: UUID().uuidString,
            title: "Elon Musk May Have Lost More Than a $55 Billion",
            body: "In this bonus Elon, Inc. episode, we take a long look at the scathing, 200-page ruling by a Delaware judge that could reshape Musk's empire.",
            link: URL(string: "https://www.wired.com/story/seagrass-humble-ocean-plant-worth-trillions/")!,
            categoryName: "racing",
            tags: CommunityTag.previewArray,
            userId: "DonaldTrump JoeBiden",
            communityId: "12345",
            creationDate: .now,
            approvedDate: .now,
            archivedDate: .now,
            upVoteCount: 5,
            downVoteCount: 27,
            commentCount: 55
        )
    }
    
    static var previewArray: [Post] {
        var postArray: [Post] = []
        for _ in 0...25 {
            postArray.append(Post.preview)
        }
        return postArray
    }
}
