//
//  UserLocalRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/13/23.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

// This shoud store info about the signed in user.
protocol UserLocalRepositoryProtocol {
    func getUser() async throws -> User
    func signInUser(_ user: User) async throws
    func signOutUser() async throws
    func createUser(_ user: User) async throws
}

struct UserLocalRepository: UserLocalRepositoryProtocol {
    
    init() { }
    
    func getUser() async throws -> User {
        .preview
    }
    
    func signInUser(_ user: User) async throws {
        
//        try await databaseSerive.getDatabaseConnection().write { database in
//            try user.insert(database)
//        }
    }
    
    func signOutUser() async throws {
        
//        try await databaseSerive.getDatabaseConnection().write { database in
//            _ = try User.deleteAll(database)
//        }
    }
    
    // Note: The backend is responsible for creating users, this should only be called once a user
    // has been created on the backend.
    func createUser(_ user: User) async throws {
        
//        try await databaseSerive.getDatabaseConnection().write { db in
//            try user.insert(db)
//        }
        
    }
    
}

enum UserLocalRepositoryError: Error {
    case unexpected
    case noDatabase
}
