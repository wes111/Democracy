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
}

final class CreateAccountViewModel: ObservableObject {
    
    @Injected(\.accountService) private var accountService
    
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var usernameErrors: [UsernameError] = []
    
    private let coordinator: CreateAccountCoordinatorDelegate
    
    init(coordinator: CreateAccountCoordinatorDelegate) {
        self.coordinator = coordinator
        
        setupBindings()
    }
}

//MARK: - Methods
extension CreateAccountViewModel {
    
    func submitUsername() {
        //coordinator.goToCreatePassword()
    }
    
    func submitPassword() {
        
    }
}

//MARK: - Private Methods
private extension CreateAccountViewModel {
    func setupBindings() {
        
        $username
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .map { [weak self] username in
                guard let self, !username.isEmpty else { return [] }
                return self.accountService.getUsernameErrors(username)
            }
            .assign(to: &$usernameErrors)
    }
}
