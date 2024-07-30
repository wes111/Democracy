//
//  CommunityTag.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/30/24.
//

import Foundation
import SharedResourcesClientAndServer

// The domain model.
struct CommunityTag: Hashable, Codable, Identifiable, Sendable {
    let id: String // TODO: `id` and `name` should be the same, b/c names must be unique
    let communityId: String
    let name: String
    let creationDate: Date
}

extension CommunityTagDTO {
    func toCommunityTag() -> CommunityTag {
        .init(id: id, communityId: communityId, name: name, creationDate: creationDate)
    }
}
