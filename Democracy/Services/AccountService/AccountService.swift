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
    func login(email: String, password: String) async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws
    func createPhoneVerification() async throws
    func createEmailVerification() async throws
    
    func getUsernameAvailable(username: String) async throws -> Bool
    
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

// MARK: - Methods
extension AccountServiceDefault {
    
    func createUser(userName: String, password: String, email: String) async throws {
        let user = try await appwriteService.createUser(userName: userName, password: password, email: email)
        // Do something with the user.
    }
    
    func login(email: String, password: String) async throws {
        let session = try await appwriteService.login(email: email, password: password)
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws {
        let user = try await appwriteService.updatePhone(phone: phone, password: password)
        //Do something with the user
    }
    
    func createPhoneVerification() async throws {
        let token = try await appwriteService.createPhoneVerification()
        //Do something with the token.
    }
    
    func createEmailVerification() async throws {
        let token = try await appwriteService.createEmailVerification()
        //Do something with the token
    }
    
    func refreshUser() {
        
    }
    
    func updateEmail() {
        
    }
    
    func getUser() -> User {
        return .preview
    }
    
    func getUsernameAvailable(username: String) async throws -> Bool {
        try await appwriteService.getUserNameAvailable(username: username)
    }
}
