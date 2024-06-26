//
//  Comment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation
import SharedResourcesClientAndServer

// Domain model
@Observable
final class Comment: Identifiable, Hashable {
    let id: String
    let parentId: String?
    let postId: String
    let userId: String
    let creationDate: Date
    let content: String
    var upVoteCount: Int
    var downVoteCount: Int
    let responseCount: Int
    var userVote: CommentVote?
    
    init(
        id: String,
        parentId: String?,
        postId: String,
        userId: String,
        creationDate: Date,
        content: String,
        upVoteCount: Int,
        downVoteCount: Int,
        responseCount: Int
    ) {
        self.id = id
        self.parentId = parentId
        self.postId = postId
        self.userId = userId
        self.creationDate = creationDate
        self.content = content
        self.upVoteCount = upVoteCount
        self.downVoteCount = downVoteCount
        self.responseCount = responseCount
    }
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
