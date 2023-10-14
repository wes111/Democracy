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
    
    lazy var createUsernameFieldViewModel: CreateFieldViewModel<UsernameOnboarding> = {
        .init(submitAction: goToCreatePassword, coordinator: self)
    }()
    
    deinit {
        print()
    }
}

// MARK: - Protocols
extension OnboardingCoordinator: AcceptTermsCoordinatorDelegate {
    
    func goToCreateAccountSuccess() {
        let viewModel = CreateAccountSuccessViewModel(coordinator: self)
        router.push(OnboardingPath.goToCreateAccountSuccess(viewModel))
    }
}

extension OnboardingCoordinator: CreateAccountSuccessCoordinatorDelegate {
    
    func continueAccountSetup() {
        let viewModel: CreateFieldViewModel<PhoneOnboarding> = .init(submitAction: goToVerifyPhone, coordinator: self)
        router.push(OnboardingPath.goToCreatePhone(viewModel))
    }
}

extension OnboardingCoordinator {
    
    func goToCreatePassword() {
        let viewModel: CreateFieldViewModel<PasswordOnboarding> = .init(submitAction: goToCreateEmail, coordinator: self)
        router.push(OnboardingPath.goToCreatePassword(viewModel))
    }
    
    func goToCreateEmail() {
        let viewModel: CreateFieldViewModel<EmailOnboarding> = .init(submitAction: goToAcceptTerms, coordinator: self)
        router.push(OnboardingPath.goToCreateEmail(viewModel))
    }
    
    func goToAcceptTerms() {
        let viewModel = AcceptTermsViewModel(coordinator: self)
        router.push(OnboardingPath.goToAcceptTerms(viewModel))
    }
    
    func goToVerifyEmail() {
        let viewModel: CreateFieldViewModel<VerifyEmailOnboarding> = .init(submitAction: {}, coordinator: self)
        router.push(OnboardingPath.goToVerifyEmail(viewModel))
    }
    
    func goToVerifyPhone() {
        let viewModel: CreateFieldViewModel<VerifyPhoneOnboarding> = .init(submitAction: goToVerifyEmail, coordinator: self)
        router.push(OnboardingPath.goToVerifyPhone(viewModel))
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
