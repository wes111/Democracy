//
//  CreateAccountViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Factory
import Foundation

protocol CreateAccountCoordinatorDelegate: AnyObject, AcceptTermsCoordinatorDelegate, CreateFieldCoordinatorDelegate, CreateAccountSuccessCoordinatorDelegate {
    func goToCreatePassword()
    func goToCreateEmail()
    func goToVerifyEmail()
    func goToCreatePhone()
    func goToVerifyPhone()
    func goToCreateAccountSuccess()
    func goToAcceptTerms()
}

final class CreateAccountViewModel: ObservableObject {
    
    @Injected(\.accountService) private var accountService
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var usernameErrors: [UsernameValidationError] = []
    
    private weak var coordinator: CreateAccountCoordinatorDelegate?
    
    lazy var createEmailFieldViewModel: CreateFieldViewModel<EmailOnboarding> = {
        .init(submitAction: submitEmail, coordinator: coordinator)
    }()
    
    lazy var createPasswordFieldViewModel: CreateFieldViewModel<PasswordOnboarding> = {
        .init(submitAction: submitPassword, coordinator: coordinator)
    }()
    
    lazy var createUsernameFieldViewModel: CreateFieldViewModel<UsernameOnboarding> = {
        .init(submitAction: submitUsername, coordinator: coordinator)
    }()
    
    lazy var createAccountSuccessViewModel: CreateAccountSuccessViewModel = {
        .init(coordinator: coordinator)
    }()
    
    lazy var acceptTermsViewModel: AcceptTermsViewModel = {
        .init(coordinator: coordinator)
    }()
    
    init(coordinator: CreateAccountCoordinatorDelegate?) {
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    deinit {
        print()
    }
}

//MARK: - Methods
extension CreateAccountViewModel {
    
    func submitUsername() {
        coordinator?.goToCreatePassword()
    }
    
    func submitPassword() {
        coordinator?.goToCreateEmail()
    }
    
    func submitEmail() {
        coordinator?.goToAcceptTerms()
        //coordinator.goToCreateAccountSuccess()
        //coordinator.goToVerifyEmail()
    }
    
    func verifyEmail() {
        coordinator?.goToCreatePhone()
    }
    
    func submitPhone() {
        coordinator?.goToVerifyPhone()
    }
    
    func agreeToTerms() {
        coordinator?.goToCreateAccountSuccess()
    }
}

//MARK: - Private Methods
private extension CreateAccountViewModel {
    func setupBindings() {
        
//        $username
//            .debounce(for: 0.25, scheduler: RunLoop.main)
//            .map { username in
//                guard !username.isEmpty else { return [] }
//                return UsernameValidationError.getFieldValidationErrors(fieldString: username)
//            }
//            .assign(to: &$usernameErrors)
    }
}
