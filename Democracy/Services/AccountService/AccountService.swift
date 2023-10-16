//
//  AccountService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/28/23.
//

import Combine
import Factory
import Foundation

protocol AccountService {
    func createUser(userName: String, password: String, email: String) async throws
    func getUser() -> User
    
    var loginPublisher: AnyPublisher<LoginStatus, Never> { get }
}

final class AccountServiceDefault: AccountService {
    
    @Injected(\.appwriteService) private var appwriteService
    
    private let loginSubject = CurrentValueSubject<LoginStatus, Never>(.loggedOut)
    
    init() {}
}

extension AccountServiceDefault {
    var loginPublisher: AnyPublisher<LoginStatus, Never> {
        loginSubject.eraseToAnyPublisher()
    }
}

//MARK: Methods
extension AccountServiceDefault {
    
    func createUser(userName: String, password: String, email: String) async throws {
        let user = try await appwriteService.createUser(userName: userName, password: password, email: email)
        //Do something with the user.
    }
    
    func refreshUser() {
        
    }
    
    func updateEmail() {
        
    }
    
    func getUser() -> User {
        return .preview
    }
}
