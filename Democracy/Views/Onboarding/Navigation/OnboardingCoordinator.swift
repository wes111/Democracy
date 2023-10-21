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
    
    lazy var createUsernameFieldViewModel: OnboardingUserInputViewModel<UsernameValidator> = {
        .init(coordinator: self)
    }()
    
    deinit {
        print()
    }
}

//MARK: - Single NEW protocool.
extension OnboardingCoordinator: OnboardingCoordinatorDelegate {
    
    func didSubmitUsername() {
        let viewModel = OnboardingUserInputViewModel<PasswordValidator>(coordinator: self)
        router.push(OnboardingPath.goToCreatePassword(viewModel))
    }
    
    func submitPassword() {
        let viewModel = OnboardingUserInputViewModel<EmailValidator>(coordinator: self)
        router.push(OnboardingPath.goToCreateEmail(viewModel))
    }
    
    func submitEmail() {
        let viewModel = AcceptTermsViewModel(coordinator: self)
        router.push(OnboardingPath.goToAcceptTerms(viewModel))
    }
    
    func agreeToTerms() {
        let viewModel = CreateAccountSuccessViewModel(coordinator: self)
        router.push(OnboardingPath.goToCreateAccountSuccess(viewModel))
    }
    
    func continueAccountSetup() {
        let viewModel = OnboardingUserInputViewModel<PhoneValidator>(coordinator: self)
        router.push(OnboardingPath.goToCreatePhone(viewModel))
    }
    
    func submitPhone() {
//        let viewModel = OnboardingUserInputViewModel<VerifyPhoneValidator>(coordinator: self)
//        router.push(OnboardingPath.goToVerifyPhone(viewModel))
        let viewModel = OnboardingUserInputViewModel<VerifyEmailValidator>(coordinator: self)
        router.push(OnboardingPath.goToVerifyEmail(viewModel))
    }
    
//    func submitPhoneVerification() {
//        let viewModel = OnboardingUserInputViewModel<VerifyEmailValidator>(coordinator: self)
//        router.push(OnboardingPath.goToVerifyEmail(viewModel))
//    }
    
    func submitEmailVerification() {
        close()
    }
    
    func goBack() {
        router.pop()
    }
    
    func close() {
        parentCoordinator?.dismiss()
    }
}
