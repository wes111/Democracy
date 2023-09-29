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

}

protocol LoginViewModelProtocol: ObservableObject {

    var username: String { get set }
    var password: String { get set }
    
    func login() async
    func createAccount()
    func signOut()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    @Published var email = ""
    @Published var isValid = false
    @Published var password = ""
    @Published var username = ""
    @Published var showEmailError = false
    @Published var showPasswordError = false
    @Published var showUsernameError = false
    
    @Injected(\.accountService) var accountService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    var coordinator: LoginCoordinatorDelegate
}

//MARK: - Methods
extension LoginViewModel {
    
    func login() async {
        print("Log in.")
        
        do {
            //try await appwriteService.test()
        } catch {
            print(error)
        }
        
        // Add spinner.
        // if login successful
        temp_authPublisher.send(true)
        //coordinator.goToMainView()
        // else show error
    }
    
    func createAccount() {
        Task {
            do {
                //try await userInteractor.createUser()
            } catch {
                print("\(error)")
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                //try await userInteractor.signOutUser()
            } catch {
                print("\(error)")
            }
        }
    }
}

//MARK: - Private Methods
private extension LoginViewModel {
    
    func setupBindings() {
        
        $email
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { [weak self] email in
                guard let self, !email.isEmpty else { return false }
                return !self.accountService.isValidEmail(email)
            }
            .assign(to: &$showUsernameError)
        
        $password
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { [weak self] password in
                guard let self, !password.isEmpty else { return false }
                return !self.accountService.isValidPassword(password)
            }
            .assign(to: &$showUsernameError)
        
        $username
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { [weak self] username in
                guard let self, !username.isEmpty else { return false }
                return !self.accountService.isValidUsername(username)
            }
            .assign(to: &$showUsernameError)
        
        $username.combineLatest($password, $email)
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { [weak self] (username, password, email) in
                guard let self else { return nil }
                return self.accountService.isValidUsername(username) && self.accountService.isValidPassword(password) && self.accountService.isValidEmail(email)
            }
            .assign(to: &$isValid)
    }
}
