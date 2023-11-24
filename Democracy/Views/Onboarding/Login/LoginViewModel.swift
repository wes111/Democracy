//
//  LoginViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import Combine
import Factory
import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    func goToCreateAccount()
}

final class LoginViewModel: ObservableObject {
    
    @Published var isValid = false
    @Published var password = ""
    @Published var username = ""
    @Published var showPasswordError = false
    @Published var showUsernameError = false
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    private weak var coordinator: LoginCoordinatorDelegate?
}

//MARK: - Methods
extension LoginViewModel {
    
    func createAccount() {
        print("Create account")
        coordinator?.goToCreateAccount()
    }
    
    func forgotPassword() {
        print("Forgot password")
        //TODO: ....
    }
    
    func login() async {
        print("Log in.")
        //TODO: ....
    }
}

//MARK: - Private Methods
private extension LoginViewModel {
    
    func setupBindings() {
        
//        $password
//            .debounce(for: 0.25, scheduler: RunLoop.main)
//            .map { password in
//                guard !password.isEmpty else { return false }
//                return !PasswordValidationError.fullyValid(string: password)
//            }
//            .assign(to: &$showUsernameError)
//        
//        $username
//            .debounce(for: 0.25, scheduler: RunLoop.main)
//            .map { username in
//                guard !username.isEmpty else { return false }
//                return !UsernameValidationError.fullyValid(string: username)
//            }
//            .assign(to: &$showUsernameError)
//        
//        $username.combineLatest($password)
//            .debounce(for: 0.25, scheduler: RunLoop.main)
//            .compactMap { (username, password) in
//                return UsernameValidationError.fullyValid(string: username) && PasswordValidationError.fullyValid(string: password)
//            }
//            .assign(to: &$isValid)
    }
}
