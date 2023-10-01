//
//  OnboardingCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

final class OnboardingCoordinator: Coordinator {
    
    
}

// MARK: - Child ViewModels
extension OnboardingCoordinator {
    
    func loginViewModel() -> LoginViewModel {
        .init(coordinator: self)
    }
    
    func createAccountViewModel() -> CreateAccountViewModel {
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
        router.push(OnboardingPath.goToCreateAccount)
    }
}
