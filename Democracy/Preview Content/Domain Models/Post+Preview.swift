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
        title: "The Title of a Post",
        body: "The body of this post",
        link: URL(string: "https://www.wired.com/story/seagrass-humble-ocean-plant-worth-trillions/")!,
        creator: User.preview,
        tags: [ "Dog", "Cat", "Mouse", "Horse", "Elephant", "Zebra", "Donkey", "Chicken"])
    
    static let previewArray: [Post] = {
        var postArray: [Post] = []
        for _ in 0...25 {
            postArray.append(Post(
                title: "The Title of a Post",
                body: "The body of this post",
                link: URL(string: "https://www.wired.com/story/seagrass-humble-ocean-plant-worth-trillions/")!,
                creator: User.preview,
                tags: [ "Dog", "Cat", "Mouse", "Horse", "Elephant", "Zebra", "Donkey", "Chicken"])
            )
        }
        return postArray
    }()
    
}
