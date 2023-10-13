//
//  RootCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/11/23.
//

import Foundation

final class RootCoordinator: Coordinator {
    
    @Published var isShowingOnboardingFlow = false
    
    func onboardingCoordinator() -> OnboardingCoordinator {
        .init(parentCoordinator: self)
    }
    
}

// MARK: - Child ViewModels
extension RootCoordinator {
    
    func loginViewModel() -> LoginViewModel {
        .init(coordinator: self)
    }
    
}

extension RootCoordinator: LoginCoordinatorDelegate {
    func goToCreateAccount() {
        isShowingOnboardingFlow = true
    }
}

extension RootCoordinator: OnboardingCoordinatorParent {
    func dismiss() {
        isShowingOnboardingFlow = false
    }
}
