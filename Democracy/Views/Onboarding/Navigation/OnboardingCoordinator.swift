//
//  OnboardingCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

final class OnboardingCoordinator: Coordinator {
    
    // TODO: Need a new coordinator that will hold this for its life and die when the create account flow is exited.
    lazy var createAccountViewModel: CreateAccountViewModel = {
        .init(coordinator: self)
    }()
    
}

// MARK: - Child ViewModels
extension OnboardingCoordinator {
    
    func loginViewModel() -> LoginViewModel {
        .init(coordinator: self)
    }
    
}

// MARK: - Protocols
extension OnboardingCoordinator: LoginCoordinatorDelegate {
    func goToCreateAccount() {
        let viewModel = createAccountViewModel.createUsernameFieldViewModel
        router.push(OnboardingPath.goToCreateAccount(viewModel))
    }
}

extension OnboardingCoordinator: AcceptTermsCoordinatorDelegate {
    func goToCreateAccountSuccess() {
        let viewModel = createAccountViewModel.createAccountSuccessViewModel
        router.push(OnboardingPath.goToCreateAccountSuccess(viewModel))
    }
}

extension OnboardingCoordinator: CreateAccountCoordinatorDelegate {
    
    func goToCreatePassword() {
        let viewModel = createAccountViewModel.createPasswordFieldViewModel
        router.push(OnboardingPath.goToCreatePassword(viewModel))
    }
    
    func goToCreateEmail() {
        let viewModel = createAccountViewModel.createEmailFieldViewModel
        router.push(OnboardingPath.goToCreateEmail(viewModel))
    }
    
    func goToVerifyEmail() {
        router.push(OnboardingPath.goToVerifyEmail)
    }
    
    func goToCreatePhone() {
        router.push(OnboardingPath.goToCreatePhone)
    }
    
    func goToVerifyPhone() {
        router.push(OnboardingPath.goToVerifyPhone)
    }
    
    func goToAcceptTerms() {
        let viewModel = createAccountViewModel.acceptTermsViewModel
        router.push(OnboardingPath.goToAcceptTerms(viewModel))
    }
}
