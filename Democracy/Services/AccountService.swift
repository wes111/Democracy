//
//  AccountService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/24/23.
//

import Asynchrone
import Factory
import Foundation
import SharedResourcesClientAndServer

enum AccountServiceError: Error {
    case noSession
    case createAccountMissingField
}

protocol AccountService {
    func getUsernameAvailable(username: String) async throws -> Bool
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool
    func getEmailAvailable(_ email: String) async throws -> Bool
    func login(email: String, password: String) async throws
    func logout() async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws
    func acceptTerms(input: OnboardingInput) async throws
    
    var sessionStream: SharedAsyncSequence<AsyncStream<Session?>> { get async }
    var currentSession: Session? { get async }
    
    var userStream: SharedAsyncSequence<AsyncStream<User?>> { get async }
}

final class AccountServiceDefault: AccountService {
    
    @Injected(\.userRepository) private var userRepository
    @Injected(\.sessionRepository) private var sessionRepository
}

// MARK: - Computed Properties
extension AccountServiceDefault {
    
    var sessionStream: SharedAsyncSequence<AsyncStream<Session?>> {
        get async {
            await sessionRepository.asyncStream
        }
    }
    
    var userStream: SharedAsyncSequence<AsyncStream<User?>> {
        get async {
            await userRepository.asyncStream
        }
    }
    
    var currentSession: Session? {
        get async {
            await sessionRepository.currentValue
        }
    }
    
    var currentUser: User? {
        get async {
            await userRepository.currentValue
        }
    }
}

// MARK: - Methods
extension AccountServiceDefault {
    
    // At this point we can create the account and log-in.
    func acceptTerms(input: OnboardingInput) async throws {
        guard let userName = input.username,
              let password = input.password,
              let email = input.email
        else {
            throw AccountServiceError.createAccountMissingField
        }
        try await userRepository.createUser(userName: userName, password: password, email: email)
        try await login(email: email, password: password)
        
        if let stringPhone = input.phone, let intPhone = Int(stringPhone) {
            try await updatePhone(phone: .init(base: intPhone), password: password)
        }
    }
    
    func getUsernameAvailable(username: String) async throws -> Bool {
        try await userRepository.getUsernameAvailable(username: username)
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        try await userRepository.getPhoneIsAvailable(phone)
    }
    
    func getEmailAvailable(_ email: String) async throws -> Bool {
        try await userRepository.getEmailAvailable(email)
    }
    
    func login(email: String, password: String) async throws {
        try await sessionRepository.createSession(email: email, password: password)
        try await userRepository.fetchSignedInUser()
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws {
        try await userRepository.updatePhone(phone: phone, password: password)
    }
    
    func logout() async throws {
        guard let currentSession = await sessionRepository.currentValue else {
            throw AccountServiceError.noSession
        }
        try await sessionRepository.deleteSession(sessionId: currentSession.id)
        try await userRepository.removePersistedUser()
    }
}
