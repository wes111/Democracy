//
//  CommunityPath.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

enum CommunityPath: Hashable {
    case postView(Post)
    case candidates
    case singleCandidate(Candidate)
    case goToCommunityPostCategory(category: CommunityCategory)
    case voteView
}
