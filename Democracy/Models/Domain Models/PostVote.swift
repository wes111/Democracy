//
//  PostVote.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/29/24.
//

import Foundation
import SharedResourcesClientAndServer

struct PostVote: Identifiable, Hashable, VoteProtocol {
    let id: String
    let creationDate: Date
    let itemId: String
    let userId: String
    var vote: VoteType? // nil means the user previosly voted, but has since removed.
    
    static func createTempVote() -> PostVote {
        .init(id: "temp", creationDate: .now, itemId: "", userId: "")
    }
}

extension PostVoteDTO {
    func toPostVote() -> PostVote {
        .init(
            id: id,
            creationDate: creationDate,
            itemId: postId,
            userId: userId,
            vote: vote
        )
    }
}
