//
//  UserInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/13/23.
//

import Combine
import Factory

protocol UserInteractorProtocol {
    
    func getUser() async throws -> User
    func createUser() async throws
    func signOutUser() async throws 
}

struct UserInteractor: UserInteractorProtocol {
    
    @Injected(\.userLocalRepository) var localRepository
    
    init() {
        
    }
    
    func getUser() async throws -> User {
        try await localRepository.getUser()
    }
    
    func createUser() async throws {
        try await localRepository.createUser(User.preview)
    }
    
    func signOutUser() async throws {
        try await localRepository.signOutUser()
    }
    
}

