//
//  AccountRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/23/23.
//
import Asynchrone
import Factory
import Foundation

protocol SessionRepository: Repository where Object == Session {
    func createSession(email: String, password: String) async throws
    func deleteSession(sessionId: String) async throws
}

actor SessionRepositoryDefault: SessionRepository, UserDefaultsStorable {
    
    @Injected(\.appwriteService) private var appwriteService
    let key: UserDefaultsKey = .session
    var currentValue: Session?
    var continuation: AsyncStream<Session?>.Continuation?
    
    lazy var asyncStream: SharedAsyncSequence<AsyncStream<Session?>> = {
        AsyncStream { continuation in
            self.continuation = continuation
        }.shared()
    }()
    
    init() {
        setup()
    }
}

// MARK: - Methods
extension SessionRepositoryDefault {
    func setupStreams() async throws {
        for try await object in asyncStream {
            currentValue = object
            if let object {
                deleteSessionIfNearExpiration(object)
            }
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
}

// MARK: - Private Methods
private extension SessionRepositoryDefault {
    
    nonisolated func setup() {
        Task {
            do {
                try await setupStreams()
            } catch {
                print(error.localizedDescription)
            }
        }
        Task {
            do {
                try await loadObject()
                try await refreshSession()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteSessionIfNearExpiration(_ session: Session) {
        Task {
            if session.expirationDate < Calendar.current.addDaysToNow(dayCount: 3) {
                do {
                    try await deleteSession(sessionId: session.id)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func refreshSession() async throws {
        do {
            let currentSession = try await appwriteService.getCurrentSession()
            try await saveObject(currentSession)
        } catch {
            if error.localizedDescription == AppwriteError.noSession.rawValue {
                try await deleteObject()
            } else {
                throw error
            }
        }
    }
}
