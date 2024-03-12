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
@Observable
final class AccountInputFlowViewModel: InputFlowViewModel, CreateAccountFlowCoordinator {
    var flowPath: AccountFlow?
    private let input = CreateAccountInput()
    private weak var coordinator: CreateAccountCoordinator?
    
    init(coordinator: CreateAccountCoordinator?) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func didSubmit(flow: AccountFlow.ID) {
        switch flow {
        case .username:
            let viewModel = AccountEmailViewModel(createAccountInput: input, flowCoordinator: self)
            flowPath = .email(viewModel)
            
        case .email:
            let viewModel = AccountPasswordViewModel(createAccountInput: input, flowCoordinator: self)
            flowPath = .password(viewModel)
            
        case .password:
            let viewModel = AccountPhoneViewModel(createAccountInput: input, flowCoordinator: self)
            flowPath = .phone(viewModel)
            
        case .phone:
            let viewModel = AccountAcceptTermsViewModel(createAccountInput: input, flowCoordinator: self)
            flowPath = .acceptTerms(viewModel)
            
        case .acceptTerms:
            coordinator?.goToSuccess()
        }
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [OnboardingTopButton] {
        shouldShowBackButton ? [.back] : []
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
    
    @MainActor
    func close() {
        coordinator?.close()
    }
}
