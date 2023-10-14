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

extension OnboardingCoordinator: CreateAccountSuccessCoordinatorDelegate {
    
    func continueAccountSetup() {
        let viewModel = createAccountViewModel.createPhoneFieldViwModel
        router.push(OnboardingPath.goToCreatePhone(viewModel))
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
        let viewModel = createAccountViewModel.verifyEmailViewModel
        router.push(OnboardingPath.goToVerifyEmail(viewModel))
    }
    
    func goToVerifyPhone() {
        let viewModel = createAccountViewModel.verifyPhoneViewModel
        router.push(OnboardingPath.goToVerifyPhone(viewModel))
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
