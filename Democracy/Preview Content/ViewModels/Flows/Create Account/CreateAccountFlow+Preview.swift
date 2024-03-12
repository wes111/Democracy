//
//  CreateAccountFlow+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import Foundation

extension AccountInputFlowViewModel {
    static let preview = AccountInputFlowViewModel(coordinator: .preview)
}

extension AccountUsernameViewModel {
    static let preview = AccountUsernameViewModel(
        createAccountInput: .init(),
        flowCoordinator: AccountInputFlowViewModel.preview
    )
}

extension AccountEmailViewModel {
    static let preview = AccountEmailViewModel(
        createAccountInput: .init(),
        flowCoordinator: AccountInputFlowViewModel.preview
    )
}

extension AccountPasswordViewModel {
    static let preview = AccountPasswordViewModel(
        createAccountInput: .init(),
        flowCoordinator: AccountInputFlowViewModel.preview
    )
}

extension AccountPhoneViewModel {
    static let preview = AccountPhoneViewModel(
        createAccountInput: .init(),
        flowCoordinator: AccountInputFlowViewModel.preview
    )
}

extension AccountAcceptTermsViewModel {
    static let preview = AccountAcceptTermsViewModel(
        createAccountInput: .init(),
        flowCoordinator: AccountInputFlowViewModel.preview
    )
}
