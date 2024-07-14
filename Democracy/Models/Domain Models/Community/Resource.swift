//
//  Resource.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/4/24.
//

import Foundation
import SharedResourcesClientAndServer

// Domain Object.
struct Resource: Hashable, Codable, Identifiable {
    let id: String
    let title: String
    let description: String?
    let link: URL?
    let category: ResourceCategory
    let communityId: String
    
    func toCreationRequest() -> ResourceCreationRequest {
        .init(
            title: title,
            description: description,
            link: link,
            category: category,
            communityId: communityId
        )
    }
}

extension ResourceDTO {
    func toResource() -> Resource {
        .init(
            id: id,
            title: title,
            description: description,
            link: link,
            category: category,
            communityId: communityId
        )
    }
}
