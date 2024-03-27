//
//  CommunityViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension CommunityViewModel {
    static let preview = CommunityViewModel(
        coordinator: CommunitiesCoordinator.preview, community: Community.preview
    )
}
