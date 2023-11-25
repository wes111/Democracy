//
//  UserRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/24/23.
//

import AsyncAlgorithms
import Factory
import Foundation

protocol UserRepository: Repository where Object == User {
    func createUser(userName: String, password: String, email: String) async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws
}

actor UserRepositoryDefault: UserRepository, UserDefaultsStorable {
    @Injected(\.appwriteService) private var appwriteService
    
    // Local storage conformance
    let asyncChannel = AsyncChannel<User?>() // <-- This should allow multiple consumers? If not we need a different solution.
    let key: UserDefaultsKey = .user
    var currentValue: User?
    
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
