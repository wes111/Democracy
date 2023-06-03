//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

extension Post {
    
    static let preview = Post(
        title: "The Title of a Post",
        subtitle: "The subtitle for this post",
        body: "The body of this post",
        creator: User.preview,
        tags: [
            Tag(name: "Dog"),
            Tag(name: "Cat"),
            Tag(name: "Mouse"),
            Tag(name: "Horse"),
            Tag(name: "Elephant"),
            Tag(name: "Zebra"),
            Tag(name: "Donkey"),
            Tag(name: "Chicken")
        ],
        link: Link(url: URL(string: "https://www.wired.com/story/seagrass-humble-ocean-plant-worth-trillions/")!)
    )
    
    static let previewArray: [Post] = {
        var postArray: [Post] = []
        for _ in 0...25 {
            postArray.append(Post(
                title: "The Title of a Post",
                body: "The body of this post",
                creator: User.preview,
                tags: [
                    Tag(name: "Dog"),
                    Tag(name: "Cat"),
                    Tag(name: "Mouse"),
                    Tag(name: "Horse"),
                    Tag(name: "Elephant"),
                    Tag(name: "Zebra"),
                    Tag(name: "Donkey"),
                    Tag(name: "Chicken")
                ],
                link: Link(url: URL(string: "https://www.wired.com/story/seagrass-humble-ocean-plant-worth-trillions/")!)
            )
            )
        }
        return postArray
    }()
    
}
