//
//  AccountService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/24/23.
//

import Asynchrone
import Factory
import Foundation

protocol AccountService {
    func refreshSessionIfNecessary() async throws
    func getUsernameAvailable(username: String) async throws -> Bool
    func login(email: String, password: String) async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws
    func acceptTerms(input: OnboardingInput) async throws
    
    var sessionStream: SharedAsyncSequence<AsyncStream<Session?>> { get async }
}

final class AccountServiceDefault: AccountService {
    
    @Injected(\.appwriteService) private var appwriteService
    @Injected(\.userRepository) private var userRepository
    @Injected(\.sessionRepository) private var sessionRepository
    
    var sessionStream: SharedAsyncSequence<AsyncStream<Session?>> {
        get async {
            await sessionRepository.asyncStream
        }
    }
    
    func refreshSessionIfNecessary() async throws {
        try await sessionRepository.refreshSession()
        guard let session = await sessionRepository.currentValue else {
            return // The user is not signed in.
        }
        
        let threeDaysFromNow = Calendar.current.addDaysToNow(dayCount: 3)
        
        if session.expirationDate < threeDaysFromNow {
            try await appwriteService.logout(sessionId: session.id)
            //let password = try await passwordRepository.readPassword(username: session.userId)
            //try await createSession(email: <#T##String#>, password: <#T##String#>)
        }
    }
    
    // At this point we can create the account and log-in.
    func acceptTerms(input: OnboardingInput) async throws {
        guard let userName = input.username,
              let password = input.password,
              let email = input.email
        else {
            throw OnboardingError.createAccountMissingField
        }
        try await userRepository.createUser(userName: userName, password: password, email: email)
        try await login(email: email, password: password)
        
        if let stringPhone = input.phone, let intPhone = Int(stringPhone) {
            try await updatePhone(phone: .init(base: intPhone), password: password)
        }
    }
    
    func getUsernameAvailable(username: String) async throws -> Bool {
        try await appwriteService.getUserNameAvailable(username: username)
    }
    
    func login(email: String, password: String) async throws {
        try await sessionRepository.createSession(email: email, password: password)
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws {
        try await userRepository.updatePhone(phone: phone, password: password)
    }
}
