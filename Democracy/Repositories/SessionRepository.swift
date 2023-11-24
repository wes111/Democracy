//
//  AccountRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/23/23.
//

import AsyncAlgorithms
import Factory
import Foundation

protocol SessionRepository: Repository {
    func createSession(email: String, password: String) async throws
    func deleteSession(sessionId: String) async throws
    func refreshSession() async throws
}

actor SessionRepositoryDefault: SessionRepository, UserDefaultsStorable {
    @Injected(\.appwriteService) private var appwriteService
    typealias Object = Session
    
    // Local storage conformance
    let asyncChannel = AsyncChannel<Object?>() // <-- This should allow multiple consumers? If not this is kinda useless.
    let key: UserDefaultsKey = .session
    var currentValue: Object?
    
    init() {
        setup()
    }
    
    func setupStreams() async {
        for await object in asyncChannel {
            self.currentValue = object
        }
    }

    func createSession(email: String, password: String) async throws {
        let session = try await appwriteService.login(email: email, password: password)
        try await saveObject(session)
    }
    
    func deleteSession(sessionId: String) async throws {
        try await appwriteService.logout(sessionId: sessionId)
        try await deleteObject()
    }
    
    func refreshSession() async throws {
        let currentSession = try await appwriteService.getCurrentSession()
        try await saveObject(currentSession)
    }
}
