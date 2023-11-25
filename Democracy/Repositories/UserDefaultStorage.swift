//
//  UserDefaultsService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/23.
//

import AsyncAlgorithms
import Foundation

// Unique keys for storing Codable types in UserDefaults.
enum UserDefaultsKey: String {
    case session
    case user
}

protocol UserDefaultsStorable: AnyActor, Repository {
    var key: UserDefaultsKey { get }
    
    func setup()
    func saveObject(_ object: Object) async throws
    func deleteObject() async throws
    func setupStreams() async
}

extension UserDefaultsStorable {
    
    func setup() {
        Task {
            await setupStreams()
            try await loadObject()
        }
    }
    
    func saveObject(_ object: Object) async throws {
        let encoded = try JSONEncoder().encode(object)
        defaults.set(encoded, forKey: key.rawValue)
        await asyncChannel.send(object)
    }
    
    func deleteObject() async throws {
        defaults.removeObject(forKey: key.rawValue)
        await asyncChannel.send(nil)
    }
    
    private func loadObject() async throws {
        var object: Object?
        if let data = defaults.object(forKey: key.rawValue) as? Data {
            object = try JSONDecoder().decode(Object.self, from: data)
        }
        await asyncChannel.send(object)
    }
    
    private var defaults: UserDefaults {
        UserDefaults.standard
    }
    
}
