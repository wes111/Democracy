//
//  CommunityArchiveFeedViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/24/23.
//

import Foundation

extension CommunityArchiveFeedViewModel {
    
    static let preview = CommunityArchiveFeedViewModel(
        coordinator: CommunityCoordinator.preview,
        community: Community.preview
    )
}
