//
//  UserDefaultsService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/23.
//

import Foundation

// Unique keys for storing Codable types in UserDefaults.
enum UserDefaultsKey: String {
    case session
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
