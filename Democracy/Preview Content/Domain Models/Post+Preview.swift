//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

extension Post {
    static let post = Post(
        title: "The Title of a Post",
        subtitle: "The subtitle for this post",
        body: "The body of this post",
        comments: [],
        creator: UserAccount(userName: "Hamlin"),
        tags: [
            Tag(name: "Dog"),
            Tag(name: "Cat"),
            Tag(name: "Mouse"),
            Tag(name: "Horse"),
            Tag(name: "Elephant"),
            Tag(name: "Zebra"),
            Tag(name: "Donkey"),
            Tag(name: "Chicken")
        ])
}
