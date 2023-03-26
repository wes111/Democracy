//
//  Candidate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

struct Candidate: Hashable, Identifiable, Codable {
    let id = UUID()
    let userName: String
    let firstName: String?
    let lastName: String?
    let imageName: String?
    var upVotes: Int
    var downVotes: Int
    var score: Int {
        upVotes - downVotes
    }
    let community: Community
    let isRepresentative: Bool // This will be determined by server?
}
