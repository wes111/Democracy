//
//  CommunityCardViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/3/24.
//

import Foundation

extension CommunityCardViewModel {
    static let preview: CommunityCardViewModel = .init(
        community: .preview,
        coordinator: CommunitiesCoordinator.preview
    )
}
