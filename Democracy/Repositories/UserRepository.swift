//
//  UserRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/24/23.
//

import AsyncAlgorithms
import Factory
import Foundation

// TODO: Doesn't seem to work with Factory?
protocol Repository {
    associatedtype Object: Codable, Sendable
    var asyncChannel: AsyncChannel<Object?> { get }
    var currentValue: Object? { get async }
}

protocol UserRepository: Repository {
    func createUser(userName: String, password: String, email: String) async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws
}

actor UserRepositoryDefault: UserRepository, UserDefaultsStorable {
    @Injected(\.appwriteService) private var appwriteService
    typealias Object = User
    
    // Local storage conformance
    let asyncChannel = AsyncChannel<Object?>() // <-- This should allow multiple consumers? If not this is kinda useless.
    let key: UserDefaultsKey = .user
    var currentValue: Object?
    
    init() {
        setup()
    }
    
    func setupStreams() async {
        for await object in asyncChannel {
            self.currentValue = object
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
}
