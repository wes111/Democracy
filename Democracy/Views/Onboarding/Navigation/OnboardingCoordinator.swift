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
        router.push(OnboardingPath.goToCreateAccount)
    }
    
}

extension OnboardingCoordinator: CreateAccountCoordinatorDelegate {
    func goBack() {
        router.pop()
    }
    
    func goToCreatePassword() {
        router.push(OnboardingPath.goToCreatePassword)
    }
}
