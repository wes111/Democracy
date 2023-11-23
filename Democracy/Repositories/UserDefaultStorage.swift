//
//  UserDefaultsService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/23.
//

import Combine
import Factory
import Foundation

struct Credentials {
    let username: String
    let password: String
}

// Unique keys for storing Codable types in UserDefaults.
enum UserDefaultsKey: String {
    case session
}

final class AccountRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    private var session: Session?
    private var user: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    func setupBindings() {
        sessionRepository.publisher
            .assign(to: \.session, on: self)
            .store(in: &cancellables)
    }
    
    lazy var sessionRepository: UserDefaultStorageDefault<Session> = {
        .init(key: UserDefaultsKey.session.rawValue)
    }()
    
    private func updateCurrentSession() async throws {
        let currentSession = try await appwriteService.getCurrentSession()
        try sessionRepository.saveObject(currentSession)
    }
    
    func createSession(email: String, password: String) async throws {
        let session = try await appwriteService.login(email: email, password: password)
        try sessionRepository.saveObject(session)
    }
    
    func deleteSession(sessionId: String) async throws {
        try await appwriteService.logout(sessionId: sessionId)
        try sessionRepository.deleteObject()
    }
    
    func refreshSessionIfNecessary() async throws {
        try await updateCurrentSession()
        guard let session else {
            return // The user is not signed in.
        }
        let threeDaysFromNow = Calendar.current.addDaysToNow(dayCount: 3)
        
        if session.expirationDate < threeDaysFromNow {
            try await appwriteService.logout(sessionId: session.id)
            try await createSession(email: <#T##String#>, password: <#T##String#>)
        }
    }
}


enum UserDefaultsStorageError: Error {
    case keyDoesNotExist
}

// To be used for singleton user preferences.
protocol UserDefaultStorage: AnyObject {
    associatedtype Object: Codable
    
    init(key: String) throws
    func saveObject(_ object: Object) throws
    func deleteObject() throws
    
    var publisher: AnyPublisher<Object?, Never> { get }
}

final class UserDefaultStorageDefault<T: Codable>: UserDefaultStorage {
    private let subject = CurrentValueSubject<T?, Never>(nil)
    private let key: String
    
    var publisher: AnyPublisher<T?, Never> {
        subject.eraseToAnyPublisher()
    }
    
    init(key: String) {
        self.key = key
        
        do {
            try fetchObject()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveObject(_ object: T) throws {
        let encoded = try JSONEncoder().encode(object)
        defaults.set(encoded, forKey: key)
        subject.send(object)
    }
    
    func deleteObject() throws {
        defaults.removeObject(forKey: key)
        subject.send(nil)
    }
}

// MARK: - Private Vars and Methods
private extension UserDefaultStorageDefault {
    
    var defaults: UserDefaults {
        UserDefaults.standard
    }
    
    func fetchObject() throws {
        var object: T?
        if let data = defaults.object(forKey: key) as? Data {
            object = try JSONDecoder().decode(T.self, from: data)
        }
        subject.send(object)
    }
}
