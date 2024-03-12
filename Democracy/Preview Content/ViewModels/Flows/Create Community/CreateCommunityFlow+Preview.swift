//
//  CommunityNameViewModel+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

extension CommunityInputFlowViewModel {
    static let preview = CommunityInputFlowViewModel(coordinator: .preview)
}

extension CommunityNameViewModel {
    static let preview = CommunityNameViewModel(
        submitCommunityInput: .init(),
        flowCoordinator: CommunityInputFlowViewModel.preview
    )
}

extension CommunityDescriptionViewModel {
    static let preview = CommunityDescriptionViewModel(
        submitCommunityInput: .init(),
        flowCoordinator: CommunityInputFlowViewModel.preview
    )
}

extension CommunityCategoriesViewModel {
    static let preview = CommunityCategoriesViewModel(
        submitCommunityInput: .init(),
        flowCoordinator: CommunityInputFlowViewModel.preview
    )
}

extension CommunityTagsViewModel {
    static let preview = CommunityTagsViewModel(
        submitCommunityInput: .init(),
        flowCoordinator: CommunityInputFlowViewModel.preview
    )
}

extension CommunityRulesViewModel {
    static let preview = CommunityRulesViewModel(
        submitCommunityInput: .init(),
        flowCoordinator: CommunityInputFlowViewModel.preview
    )
}

extension CommunitySettingsViewModel {
    static let preview = CommunitySettingsViewModel(
        submitCommunityInput: .init(),
        flowCoordinator: CommunityInputFlowViewModel.preview
    )
}

extension CommunityResourcesViewModel {
    static let preview = CommunityResourcesViewModel(
        submitCommunityInput: .init(),
        flowCoordinator: CommunityInputFlowViewModel.preview
    )
}
