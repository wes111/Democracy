//
//  OnboardingCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

protocol OnboardingCoordinatorParent: AnyObject {
    func dismiss()
}

final class OnboardingCoordinator: Coordinator {
    
    weak var parentCoordinator: OnboardingCoordinatorParent?
    
    init(parentCoordinator: OnboardingCoordinatorParent?) {
        self.parentCoordinator = parentCoordinator
    }
    
    lazy var createAccountViewModel: CreateAccountViewModel = {
        .init(coordinator: self)
    }()
    
    deinit {
        print()
    }
    
}

// MARK: - Protocols
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

extension OnboardingCoordinator: CreateFieldCoordinatorDelegate {
    func goBack() {
        router.pop()
    }
    
    func close() {
        parentCoordinator?.dismiss()
    }
}
