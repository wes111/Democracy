//
//  OnboardingCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Foundation

@MainActor
protocol OnboardingCoordinatorParent: AnyObject {
    func dismiss()
}

@MainActor @Observable
final class OnboardingCoordinator {
    
    weak var parentCoordinator: OnboardingCoordinatorParent?
    var router = Router()
    
    init(parentCoordinator: OnboardingCoordinatorParent?) {
        self.parentCoordinator = parentCoordinator
    }
    
    @ObservationIgnored lazy var createUsernameFieldViewModel: UsernameInputViewModel = {
        .init(coordinator: self)
    }()
    
    deinit {
        print()
    }
}

// MARK: - Single NEW protocool.
extension OnboardingCoordinator: OnboardingCoordinatorDelegate {
    
    func didSubmitUsername(input: OnboardingInput) {
        let viewModel = PasswordInputViewModel(coordinator: self, onboardingInput: input)
        router.push(OnboardingPath.goToCreatePassword(viewModel))
    }
    
    func submitPassword(input: OnboardingInput) {
        let viewModel = EmailInputViewModel(coordinator: self, onboardingInput: input)
        router.push(OnboardingPath.goToCreateEmail(viewModel))
    }
    
    func submitEmail(input: OnboardingInput) {
        let viewModel = PhoneInputViewModel(coordinator: self, onboardingInput: input)
        router.push(OnboardingPath.goToCreatePhone(viewModel))
    }
    
    func submitPhone(input: OnboardingInput) {
        let viewModel = AcceptTermsViewModel(coordinator: self, onboardingInput: input)
        router.push(OnboardingPath.goToAcceptTerms(viewModel))
    }
    
    func agreeToTerms(username: String) {
        let viewModel = CreateAccountSuccessViewModel(
            closeAction: close,
            continueAction: continueAccountSetup,
            username: username
        )
        router.push(OnboardingPath.goToCreateAccountSuccess(viewModel))
    }
    
    func continueAccountSetup() {
    }
    
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
