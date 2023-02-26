//
//  LoginViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import Foundation

protocol LoginCoordinatorDelegate {

}

protocol LoginViewModelProtocol: ObservableObject {
    func login()
    var userName: String { get set }
    var password: String { get set }
}

final class LoginViewModel: LoginViewModelProtocol {
    
    @Published var userName: String = ""
    @Published var password: String = ""
    
    func login() {
        print("Log in.")
        // Add spinner.
        // if login successful
        temp_authPublisher.send(true)
        //coordinator.goToMainView()
        // else show error
    }
    
    var coordinator: LoginCoordinatorDelegate
    
    init(coordinator: LoginCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
}
