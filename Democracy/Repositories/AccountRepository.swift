//
//  AccountRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/23/23.
//

import AsyncAlgorithms
import Factory
import Foundation

protocol AccountRepository {
    var sessionAsyncChannel: AsyncChannel<Session?> { get }
    
    func createSession(email: String, password: String) async throws
    func deleteSession(sessionId: String) async throws
    func refreshSessionIfNecessary() async throws
}

actor AccountRepositoryDefault: AccountRepository {
    @Injected(\.appwriteService) private var appwriteService
    @Injected(\.sessionRepository) var sessionRepository
    
    let sessionAsyncChannel = AsyncChannel<Session?>() // <-- This should allow multiple consumers? If not this is useless.
    var session: Session?
    
    init() {
        Task {
            await setupBindings()
        }
    }
    
    private func setupBindings() async {
        for await session in await sessionRepository.stream {
            await sessionAsyncChannel.send(session)
        }
    }
    
    private func updateCurrentSession() async throws {
        let currentSession = try await appwriteService.getCurrentSession()
        try await sessionRepository.saveObject(currentSession)
    }
    
    func createSession(email: String, password: String) async throws {
        let session = try await appwriteService.login(email: email, password: password)
        try await sessionRepository.saveObject(session)
    }
    
    func deleteSession(sessionId: String) async throws {
        try await appwriteService.logout(sessionId: sessionId)
        try await sessionRepository.deleteObject()
    }
    
    func refreshSessionIfNecessary() async throws {
        try await updateCurrentSession()
        guard let session else {
            return // The user is not signed in.
        }
        let threeDaysFromNow = Calendar.current.addDaysToNow(dayCount: 3)
        
        if session.expirationDate < threeDaysFromNow {
            try await appwriteService.logout(sessionId: session.id)
            //try await createSession(email: <#T##String#>, password: <#T##String#>)
        }
    }
}
