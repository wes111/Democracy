//
//  UserRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/24/23.
//

import Asynchrone
import Factory
import Foundation
import SharedResourcesClientAndServer

/// Stores the single logged-in user. If there is no session, there is no user.
protocol UserRepository: Repository where Object == User {
    func createUser(userName: String, password: String, email: String) async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws
    func fetchSignedInUser() async throws
    func removePersistedUser() async throws
    func getUsernameAvailable(username: String) async throws -> Bool
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool
}

actor UserRepositoryDefault: UserRepository, UserDefaultsStorable {
    
    @Injected(\.appwriteService) private var appwriteService
    let key: UserDefaultsKey = .user
    var continuation: AsyncStream<User?>.Continuation?
    var currentValue: User?
    
    lazy var asyncStream: SharedAsyncSequence<AsyncStream<User?>> = {
        AsyncStream { continuation in
            self.continuation = continuation
        }.shared()
    }()
    
    init() {
        setup()
    }
}

// MARK: - Methods
extension UserRepositoryDefault {
    
    nonisolated private func setup() {
        Task {
            do {
                try await setupStreams()
            } catch {
                print(error.localizedDescription)
            }
        }
        Task {
            try await loadObject()
        }
    }
    
    func setupStreams() async throws {
        for try await object in asyncStream {
            currentValue = object
        }
    }
    
    func createUser(userName: String, password: String, email: String) async throws {
        let user = try await appwriteService.createUser(userName: userName, password: password, email: email)
        try await saveObject(user)
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws {
        let user = try await appwriteService.updatePhone(phone: phone, password: password)
        try await saveObject(user)
    }
    
    func fetchSignedInUser() async throws {
        let user = try await appwriteService.getCurrentLoggedInUser()
        try await saveObject(user)
    }
    
    func removePersistedUser() async throws {
        try await deleteObject()
    }
    
    func getUsernameAvailable(username: String) async throws -> Bool {
        try await appwriteService.getUserNameAvailable(username: username)
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        try await appwriteService.getPhoneIsAvailable(phone)
    }
}
