//
//  UserDefaultsService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/23.
//

import Asynchrone
import Foundation

// Unique keys for storing Codable types in UserDefaults.
enum UserDefaultsKey: String {
    case session
    case user
}

protocol UserDefaultsStorable: AnyActor, Repository {
    var key: UserDefaultsKey { get }
    var continuation: AsyncStream<Object?>.Continuation? { get async }
    
    func saveObject(_ object: Object) async throws
    func deleteObject() async throws
    func sendObject(_ object: Object?) async
    func setupStreams() async throws
}

extension UserDefaultsStorable {
    
    func setup() {
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
    
    func saveObject(_ object: Object) async throws {
        let encoded = try JSONEncoder().encode(object)
        defaults.set(encoded, forKey: key.rawValue)
        await sendObject(object)
    }
    
    func deleteObject() async throws {
        defaults.removeObject(forKey: key.rawValue)
        await sendObject(nil)
    }
    
    func loadObject() async throws {
        var object: Object?
        if let data = defaults.object(forKey: key.rawValue) as? Data {
            object = try JSONDecoder().decode(Object.self, from: data)
        }
        await sendObject(object)
    }
    
    func sendObject(_ object: Object?) async {
        await continuation?.yield(object)
    }
    
    private var defaults: UserDefaults {
        UserDefaults.standard
    }
    
}
