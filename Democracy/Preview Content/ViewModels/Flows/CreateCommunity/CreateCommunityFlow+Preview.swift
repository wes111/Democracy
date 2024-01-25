//
//  CommunityNameViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

extension CommunityNameViewModel {
    static let preview = CommunityNameViewModel(coordinator: CreateCommunityCoordinator.preview)
}

extension CommunityDescriptionViewModel {
    static let preview = CommunityDescriptionViewModel(
        coordinator: CreateCommunityCoordinator.preview,
        userInput: .init()
    )
}

extension CommunityCategoriesViewModel {
    static let preview = CommunityCategoriesViewModel()
}

extension CommunityTagsViewModel {
    static let preview = CommunityTagsViewModel()
}

extension CommunityRulesViewModel {
    static let preview = CommunityRulesViewModel()
}

extension CommunitySettingsViewModel {
    static let preview = CommunitySettingsViewModel()
}

extension CommunityLeadersViewModel {
    static let preview = CommunityLeadersViewModel()
}
