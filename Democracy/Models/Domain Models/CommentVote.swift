//
//  CommentVote.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/20/24.
//

import Foundation
import SharedResourcesClientAndServer

// Domain model
// TODO: This needs a post id...
struct CommentVote: Identifiable, Hashable {
    let id: String
    let creationDate: Date
    let commentId: String
    let userId: String
    var vote: VoteType? // nil means the user previosly voted, but has since removed.
}

extension CommentVoteDTO {
    func toCommentVote() -> CommentVote {
        .init(
            id: id,
            creationDate: creationDate,
            commentId: commentId,
            userId: userId,
            vote: vote
        )
    }
}
