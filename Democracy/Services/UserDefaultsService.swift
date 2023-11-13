//
//  UserDefaultsService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/12/23.
//

import Combine
import Foundation

// Unique keys for storing Codable types in UserDefaults.
enum UserDefaultsKey: String {
    case session
}

enum UserDefaultsServiceError: Error {
    case keyDoesNotExist
}

// To be used for singleton user preferences.
protocol UserDefaultsService: AnyObject {
    associatedtype Object: Codable
    
    init() throws
    func saveObject(_ object: Object) throws
    func deleteObject() throws
    
    var object: Object? { get }
}

@Observable final class ObservableDefaultsObject<T: Codable>: UserDefaultsService {
    private (set) var object: T?
    
    init() throws {
        try fetchObject()
    }
    
    func saveObject(_ object: T) throws {
        guard let key else {
            throw UserDefaultsServiceError.keyDoesNotExist
        }
        let encoded = try JSONEncoder().encode(object)
        defaults.set(encoded, forKey: key)
        self.object = object
    }
    
    func deleteObject() throws {
        guard let key else {
            throw UserDefaultsServiceError.keyDoesNotExist
        }
        defaults.removeObject(forKey: key)
        self.object = nil
    }
}

// MARK: - Private Vars and Methods
private extension ObservableDefaultsObject {
    
    var defaults: UserDefaults {
        UserDefaults.standard
    }
    
    var key: String? {
        switch T.self {
        case is Session.Type:
            return UserDefaultsKey.session.rawValue
            
        default:
            return nil
        }
    }
    
    func fetchObject() throws {
        guard let key else {
            throw UserDefaultsServiceError.keyDoesNotExist
        }
        var object: T?
        if let data = defaults.object(forKey: key) as? Data {
            object = try JSONDecoder().decode(T.self, from: data)
        }
        self.object = object
    }
}
