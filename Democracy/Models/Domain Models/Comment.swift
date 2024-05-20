//
//  Comment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation
import SharedResourcesClientAndServer

// Domain model
struct Comment: Identifiable, Hashable {
    let id: String
    let parentId: String?
    let postId: String
    let userId: String
    let creationDate: Date
    let content: String
    let upVoteCount: Int
    let downVoteCount: Int
    let responseCount: Int
}

extension CommentDTO {
    func toComment() -> Comment {
        .init(
            id: id,
            parentId: parentId,
            postId: postId,
            userId: userId,
            creationDate: creationDate.date,
            content: content,
            upVoteCount: upVoteCount,
            downVoteCount: downVoteCount,
            responseCount: responseCount
        )
    }
}
