//
//  CommunitiesTabPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

enum CommunitiesTabPath: Hashable {
    case goToCommunity(Community)
    case postView(Post)
    case candidates
    case singleCandidate(Candidate)
    case goToCommunityPostCategory(category: PostCategory, community: Community)
    case voteView
}
