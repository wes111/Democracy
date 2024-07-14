//
//  CommunityArchiveViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/24.
//

import Foundation

extension CommunityArchiveViewModel {
    static let preview = CommunityArchiveViewModel(
        community: .preview,
        coordinator: CommunitiesCoordinator.preview
    )
}
