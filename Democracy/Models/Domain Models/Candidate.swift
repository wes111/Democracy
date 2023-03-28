//
//  Candidate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation
import GRDB

struct Candidate: Hashable, Identifiable, Codable {
    let id: UUID // <-- link to user.
    let userName: String // TODO: Remove these 4 fields, should be in user.
    let firstName: String?
    let lastName: String?
    let imageName: String?
    var upVotes: Int
    var downVotes: Int
    var score: Int {
        upVotes - downVotes
    }
    let communityId: UUID
    let isRepresentative: Bool // This will be determined by server?
    let summary: String
    let exteneralLink: String?
}

extension Candidate: FetchableRecord, PersistableRecord {
    
}
