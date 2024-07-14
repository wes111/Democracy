//
//  Rule.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/27/24.
//

import Foundation
import SharedResourcesClientAndServer

struct Rule: Equatable, Hashable, Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let communityId: String
    
    func toCreationRequest() -> RuleCreationRequest {
        .init(communityId: communityId, title: title, description: description)
    }
}

extension RuleDTO {
    func toRule() -> Rule {
        .init(
            id: id,
            title: title,
            description: description,
            communityId: communityId
        )
    }
}
