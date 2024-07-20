//
//  Services+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Asynchrone
import Foundation
import SharedResourcesClientAndServer

final class AccountServiceMock: AccountService {
    var continuation: AsyncStream<Session?>.Continuation?
    var userContinuation: AsyncStream<User?>.Continuation?
    var currentSession: Session?
}

// MARK: - Computed Properties
extension AccountServiceMock {
    
    var sessionStream: SharedAsyncSequence<AsyncStream<Session?>> {
        AsyncStream { continuation in
            self.continuation = continuation
        }.shared()
    }
    
    var userStream: SharedAsyncSequence<AsyncStream<User?>> {
        AsyncStream { continuation in
            self.userContinuation = continuation
        }.shared()
    }
}

// MARK: - Methods
extension AccountServiceMock {
    
    func getUsernameAvailable(username: String) async throws -> Bool {
        false
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        false
    }
    
    func getEmailAvailable(_ email: String) async throws -> Bool {
        false
    }
    
    func login(email: String, password: String) async throws {
        return
    }
    
    func logout() async throws {
        return
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws {
        return
    }
    
    func acceptTerms(input: CreateAccountInput) async throws {
        return
    }
}
