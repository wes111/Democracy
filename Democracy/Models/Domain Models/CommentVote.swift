//
//  CommentVote.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/20/24.
//

import Foundation
import SharedResourcesClientAndServer

// Domain model
struct CommentVote: Identifiable, Hashable {
    let id: String
    let creationDate: Date
    let commentId: String
    let userId: String
    let vote: VoteType
}

extension CommentVoteDTO {
    func toCommentVote() -> CommentVote {
        .init(
            id: id,
            creationDate: creationDate.date,
            commentId: commentId,
            userId: userId,
            vote: vote
        )
    }
}
