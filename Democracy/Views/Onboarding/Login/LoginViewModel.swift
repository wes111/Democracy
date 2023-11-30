//
//  LoginViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import Factory
import Foundation

enum LoginAlert: Identifiable {
    case loginError
    
    var id: String {
        return self.title
    }
    
    var title: String {
        switch self {
        case .loginError: return "Login Error"
        }
    }
    
    var message: String {
        switch self {
        case .loginError: return "Please try again later"
        }
    }
}

protocol LoginCoordinatorDelegate: AnyObject {
    func goToCreateAccount()
}

final class LoginViewModel: ObservableObject {
    
    @Injected(\.accountService) private var accountService
    @Published var isValid = false
    @Published var password = ""
    @Published var email = ""
    @Published var alert: LoginAlert?
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
        setupBindings()
    }
    
    private weak var coordinator: LoginCoordinatorDelegate?
}

// MARK: - Methods
extension LoginViewModel {
    
    func createAccount() {
        coordinator?.goToCreateAccount()
    }
    
    func forgotPassword() {
        print("Forgot password")
    }
    
    @MainActor
    func login() async {
        do {
            try await accountService.login(email: email, password: password)
        } catch {
            print(error.localizedDescription)
            alert = .loginError
        }
    }
}

// MARK: - Private Methods
private extension LoginViewModel {
    
    func setupBindings() {
        $email.combineLatest($password)
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { (email, password) in
                return OnboardingInputField.email.fullyValid(input: email) &&
                OnboardingInputField.password.fullyValid(input: password)
            }
            .assign(to: &$isValid)
    }
}
