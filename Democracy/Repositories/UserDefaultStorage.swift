//
//  UserDefaultsService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/23.
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

// Unique keys for storing Codable types in UserDefaults.
enum UserDefaultsKey: String {
    case session
}

enum UserDefaultsStorageError: Error {
    case keyDoesNotExist
}

// To be used for singleton user preferences.
protocol UserDefaultStorage: AnyObject {
    associatedtype Object: Codable, Sendable
    
    init(key: String) throws
    func saveObject(_ object: Object) async throws
    func deleteObject() async throws
    func fetchObject() async throws -> Object?
    
    var stream: AsyncStream<Object?> { get async }
}

actor UserDefaultStorageDefault<T: Sendable & Codable>: UserDefaultStorage {
    private nonisolated let key: String
    private var continuation: AsyncStream<T?>.Continuation? {
        didSet {
            performInitialFetch(continuation: continuation)
        }
    }
    
    private func performInitialFetch(continuation: AsyncStream<T?>.Continuation?) {
        do {
            let object = try fetchObject()
            continuation?.yield(object)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Note: Only 1 consumer can iterate over an async stream: https://www.donnywals.com/understanding-swift-concurrencys-asyncstream/
    lazy var stream: AsyncStream<T?> = {
        AsyncStream(bufferingPolicy: .bufferingNewest(1)) { (continuation: AsyncStream<T?>.Continuation) -> Void in
            self.continuation = continuation
        }
    }()

    private var defaults: UserDefaults {
        UserDefaults.standard
    }
    
    init(key: String) {
        self.key = key
    }
    
    func saveObject(_ object: T) throws {
        let encoded = try JSONEncoder().encode(object)
        defaults.set(encoded, forKey: key)
        continuation?.yield(object)
    }
    
    func deleteObject() throws {
        defaults.removeObject(forKey: key)
        continuation?.yield(nil)
    }
    
    func fetchObject() throws -> T? {
        var object: T?
        if let data = defaults.object(forKey: key) as? Data {
            object = try JSONDecoder().decode(T.self, from: data)
        }
        return object
    }
}
