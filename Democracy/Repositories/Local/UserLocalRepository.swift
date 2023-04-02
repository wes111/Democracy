//
//  UserLocalRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/13/23.
//

import Factory
import Foundation
import GRDB

// This shoud store info about the signed in user.
protocol UserLocalRepositoryProtocol {
    func getUser() async throws -> User
    func signInUser(_ user: User) async throws
    func signOutUser() async throws
    func createUser(_ user: User) async throws
}

struct UserLocalRepository: UserLocalRepositoryProtocol {
    
    @Injected(\.grdbService) var databaseSerive
    
    init() { }
    
    func getUser() async throws -> User {
        
        let users = try await databaseSerive.getDatabaseConnection().read { db in
            try User.fetchAll(db)
        }
        
        guard users.count == 1, let user = users.first else {
            throw UserLocalRepositoryError.unexpected
        }
        
        return user
    }
    
    func signInUser(_ user: User) async throws {
        
        try await databaseSerive.getDatabaseConnection().write { database in
            try user.insert(database)
        }
    }
    
    func signOutUser() async throws {
        
        try await databaseSerive.getDatabaseConnection().write { database in
            _ = try User.deleteAll(database)
        }
    }
    
    // Note: The backend is responsible for creating users, this should only be called once a user
    // has been created on the backend.
    func createUser(_ user: User) async throws {
        
        try await databaseSerive.getDatabaseConnection().write { db in
            try user.insert(db)
        }
        
    }
    
}

enum UserLocalRepositoryError: Error {
    case unexpected
    case noDatabase
}
