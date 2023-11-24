//
//  AccountService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/24/23.
//

import Factory
import Foundation

protocol AccountService {
    func refreshSessionIfNecessary() async throws
    func getUsernameAvailable(username: String) async throws -> Bool
    func createUser(userName: String, password: String, email: String) async throws
    func login(email: String, password: String) async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws
}

final class AccountServiceDefault: AccountService {
    
    @Injected(\.appwriteService) private var appwriteService
    @Injected(\.userRepository) private var userRepository
    @Injected(\.sessionRepository) private var sessionRepository
    
    func refreshSessionIfNecessary() async throws {
        try await sessionRepository.refreshSession()
        guard let session = await sessionRepository.currentValue as? Session else {
            return // The user is not signed in.
        }
        
        let threeDaysFromNow = Calendar.current.addDaysToNow(dayCount: 3)
        
        if session.expirationDate < threeDaysFromNow {
            try await appwriteService.logout(sessionId: session.id)
            //let password = try await passwordRepository.readPassword(username: session.userId)
            //try await createSession(email: <#T##String#>, password: <#T##String#>)
        }
    }
    
    func getUsernameAvailable(username: String) async throws -> Bool {
        try await appwriteService.getUserNameAvailable(username: username)
    }
    
    func createUser(userName: String, password: String, email: String) async throws {
       try await userRepository.createUser(userName: userName, password: password, email: email)
    }
    
    func login(email: String, password: String) async throws {
        try await sessionRepository.createSession(email: email, password: password)
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws {
        try await userRepository.updatePhone(phone: phone, password: password)
    }
}
