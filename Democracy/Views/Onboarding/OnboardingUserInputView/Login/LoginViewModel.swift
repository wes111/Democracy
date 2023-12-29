//
//  LoginViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import Combine
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
    @Published var password = ""
    @Published var email = ""
    @Published var alert: LoginAlert?
    @Published var isShowingProgress = false
    
    var bob = Set<AnyCancellable>()
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
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
            try await Task.sleep(seconds: 3.0)
            try await accountService.login(email: email, password: password)
        } catch {
            print(error.localizedDescription)
            alert = .loginError
        }
    }
}
