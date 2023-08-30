//
//  CommunityCoordinatorViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/5/23.
//

import Foundation

extension CommunityCoordinator {
    static let preview = CommunityCoordinator(
        community: Community.preview,
        router: .preview,
        parentCoordinator: CommunitiesTabCoordinator.preview
    )
}
