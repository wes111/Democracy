//
//  Candidate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

struct Candidate: Hashable, Identifiable, Codable {
    let id: String // <-- link to user.
    let userName: String
    let firstName: String?
    let lastName: String?
    let imageName: String?
    var upVotes: Int
    var downVotes: Int
    var score: Int {
        upVotes - downVotes
    }
    let communityId: String
    let isRepresentative: Bool // This will be determined by server?
    let summary: String
    let externalLink: String?
    let repType: RepresentativeType
    let badges: [CandidateBadge]
}
