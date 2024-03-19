//
//  AccountInputFlowViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/11/24.
//

import Foundation

protocol CreateAccountFlowCoordinator: AnyObject {
    @MainActor func didSubmit(flow: AccountFlow.ID)
}

// The InputFlowViewModel for creating new Account/User objects.
@MainActor @Observable
final class AccountInputFlowViewModel: InputFlowViewModel, CreateAccountFlowCoordinator {
    var flowPath: AccountFlow?
    private let input = CreateAccountInput()
    private weak var coordinator: CreateAccountCoordinator?
    
    init(coordinator: CreateAccountCoordinator?) {
        self.coordinator = coordinator
    }
    
    func goBack() {
        switch flowPath {
        case .username, nil: return
        case .email: toUsername()
        case .password: toEmail()
        case .phone: toPassword()
        case .acceptTerms: toPhone()
        }
    }
    
    func didSubmit(flow: AccountFlow.ID) {
        switch flow {
        case .username: toEmail()
        case .email: toPassword()
        case .password: toPhone()
        case .phone: toAcceptTerms()
        case .acceptTerms: coordinator?.goToSuccess()
        }
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [OnboardingTopButton] {
        shouldShowBackButton ? [.back(goBack)] : []
    }
    
    var shouldShowBackButton: Bool {
        guard let flowPath else {
            return false
        }
        
        return switch flowPath {
        case .username:
            false
        case .email, .password, .phone, .acceptTerms:
            true
        }
    }
    
    func close() {
        coordinator?.close()
    }
}

// MARK: - Private Methods
private extension AccountInputFlowViewModel {
    
    func toUsername() {
        let viewModel = AccountUsernameViewModel(createAccountInput: input, flowCoordinator: self)
        flowPath = .username(viewModel)
    }
    
    func toEmail() {
        let viewModel = AccountEmailViewModel(createAccountInput: input, flowCoordinator: self)
        flowPath = .email(viewModel)
    }
    
    func toPassword() {
        let viewModel = AccountPasswordViewModel(createAccountInput: input, flowCoordinator: self)
        flowPath = .password(viewModel)
    }
    
    func toPhone() {
        let viewModel = AccountPhoneViewModel(createAccountInput: input, flowCoordinator: self)
        flowPath = .phone(viewModel)
    }
    
    func toAcceptTerms() {
        let viewModel = AccountAcceptTermsViewModel(createAccountInput: input, flowCoordinator: self)
        flowPath = .acceptTerms(viewModel)
    }
}
