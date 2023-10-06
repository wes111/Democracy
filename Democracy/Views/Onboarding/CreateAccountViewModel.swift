//
//  CreateAccountViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import Factory
import Foundation

protocol CreateAccountCoordinatorDelegate {
    func goToCreatePassword()
    func goToCreateEmail()
    func goToVerifyEmail()
    func goToCreatePhone()
    func goToVerifyPhone()
}

final class CreateAccountViewModel: ObservableObject {
    
    @Injected(\.accountService) private var accountService
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var usernameErrors: [UserNameValidation] = []
    
    private let coordinator: CreateAccountCoordinatorDelegate
    
    lazy var createEmailFieldViewModel: CreateFieldViewModel<EmailValidation> = {
        .init(submitAction: submitEmail)
    }()
    
    lazy var createPasswordFieldViewModel: CreateFieldViewModel<PasswordValidation> = {
        .init(submitAction: submitPassword)
    }()
    
    lazy var createUsernameFieldViewModel: CreateFieldViewModel<UserNameValidation> = {
        .init(submitAction: submitUsername)
    }()
    
    init(coordinator: CreateAccountCoordinatorDelegate) {
        self.coordinator = coordinator
        
        setupBindings()
    }
}

//MARK: - Methods
extension CreateAccountViewModel {
    
    func submitUsername() {
        coordinator.goToCreatePassword()
    }
    
    func submitPassword() {
        coordinator.goToCreateEmail()
    }
    
    func submitEmail() {
        coordinator.goToVerifyEmail()
    }
    
    func verifyEmail() {
        coordinator.goToCreatePhone()
    }
    
    func submitPhone() {
        coordinator.goToVerifyPhone()
    }
}

//MARK: - Private Methods
private extension CreateAccountViewModel {
    func setupBindings() {
        
        $username
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { username in
                guard !username.isEmpty else { return [] }
                return UserNameValidation.getFieldValidationErrors(fieldString: username)
            }
            .assign(to: &$usernameErrors)
    }
}
