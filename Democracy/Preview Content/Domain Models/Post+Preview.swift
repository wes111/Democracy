//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation
import SharedResourcesClientAndServer

extension Post {
    
    static let preview = Post(
        id: "123",
        title: "Post Title",
        body: "Post Body",
        link: URL(string: "https://www.wired.com/story/seagrass-humble-ocean-plant-worth-trillions/")!,
        category: "racing",
        tags: [ "Dog", "Cat", "Mouse", "Horse", "Elephant", "Zebra", "Donkey", "Chicken"],
        userId: "1234",
        communityId: "12345",
        creationDate: .now,
        // rootCommentIds: [],
        approvedDate: .now
    )
    
    static let previewArray: [Post] = {
        var postArray: [Post] = []
        for _ in 0...25 {
            postArray.append(Post.preview)
        }
        return postArray
    }()
    
}
