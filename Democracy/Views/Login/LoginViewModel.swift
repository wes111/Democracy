//
//  LoginViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import Factory
import Foundation

protocol LoginCoordinatorDelegate {

}

protocol LoginViewModelProtocol: ObservableObject {

    var userName: String { get set }
    var password: String { get set }
    
    func login()
    func createAccount()
    func signOut()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    
    @Injected(\.userInteractor) var userInteractor
    
    func login() {
        print("Log in.")
        // Add spinner.
        // if login successful
        temp_authPublisher.send(true)
        //coordinator.goToMainView()
        // else show error
    }
    
    func createAccount() {
        Task {
            do {
                try await userInteractor.createUser()
            } catch {
                print("\(error)")
            }
        }
    }
    
    func signOut() {
        Task {
            do {
                try await userInteractor.signOutUser()
            } catch {
                print("\(error)")
            }
        }
    }
    
    var coordinator: LoginCoordinatorDelegate
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
}
