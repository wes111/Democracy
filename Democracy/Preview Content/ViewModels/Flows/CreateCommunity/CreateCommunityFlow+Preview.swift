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
    static let preview = CommunityCategoriesViewModel(
        coordinator: CreateCommunityCoordinator.preview,
        userInput: .init()
    )
}

extension CommunityTagsViewModel {
    static let preview = CommunityTagsViewModel(
        coordinator: CreateCommunityCoordinator.preview,
        userInput: .init()
    )
}

extension CommunityRulesViewModel {
    static let preview = CommunityRulesViewModel(
        coordinator: CreateCommunityCoordinator.preview,
        userInput: .init()
    )
}

extension CommunitySettingsViewModel {
    static let preview = CommunitySettingsViewModel(
        coordinator: CreateCommunityCoordinator.preview,
        userInput: .init()
    )
}

extension CommunityLeadersViewModel {
    static let preview = CommunityLeadersViewModel()
}
