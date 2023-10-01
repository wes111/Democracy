//
//  LoginViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import Combine
import Factory
import Foundation

protocol LoginCoordinatorDelegate {
    func goToCreateAccount()
}

final class LoginViewModel: ObservableObject {
    
    @Published var isValid = false
    @Published var password = ""
    @Published var username = ""
    @Published var showPasswordError = false
    @Published var showUsernameError = false
    
    @Injected(\.accountService) private var accountService
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    var coordinator: LoginCoordinatorDelegate
}

//MARK: - Methods
extension LoginViewModel {
    
    func createAccount() {
        print("Create account")
        coordinator.goToCreateAccount()
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
        
        $password
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { [weak self] password in
                guard let self, !password.isEmpty else { return false }
                print("Password valid: \(self.accountService.isValidPassword(password))")
                return !self.accountService.isValidPassword(password)
            }
            .assign(to: &$showUsernameError)
        
        $username
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { [weak self] username in
                guard let self, !username.isEmpty else { return false }
                print("Username valid: \(self.accountService.isValidUsername(username))")
                return !self.accountService.isValidUsername(username)
            }
            .assign(to: &$showUsernameError)
        
        $username.combineLatest($password)
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { [weak self] (username, password) in
                guard let self else { return nil }
                //print(self.accountService.isValidUsername(username) && self.accountService.isValidPassword(password))
                return self.accountService.isValidUsername(username) && self.accountService.isValidPassword(password)
            }
            .assign(to: &$isValid)
    }
}
