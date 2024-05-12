//
//  Comment+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/3/24.
//

import Foundation

extension Comment {
    static let preview = Comment(
        id: "",
        parentId: "",
        postId: "",
        userId: "",
        creationDate: .now,
        content: "Post body Content - Hello World!",
        upVoteCount: 10,
        downVoteCount: 5
    )
}
