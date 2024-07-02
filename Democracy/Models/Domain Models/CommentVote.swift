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
struct CommentVote: Identifiable, Hashable, VoteProtocol {
    let id: String
    let creationDate: Date
    let itemId: String
    let userId: String
    var vote: VoteType? // nil means the user previosly voted, but has since removed.
    
    init(id: String, creationDate: Date, itemId: String, userId: String, vote: VoteType? = nil) {
        self.id = id
        self.creationDate = creationDate
        self.itemId = itemId
        self.userId = userId
        self.vote = vote
    }
    
    static func createTempVote() -> CommentVote {
        .init(id: "temp", creationDate: .now, itemId: "", userId: "")
    }
}

extension CommentVoteDTO {
    func toCommentVote() -> CommentVote {
        .init(
            id: id,
            creationDate: creationDate,
            itemId: commentId,
            userId: userId,
            vote: vote
        )
    }
}
