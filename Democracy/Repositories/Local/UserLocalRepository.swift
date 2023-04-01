//
//  UserLocalRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/13/23.
//

import Foundation

// This shoud store info about the signed in user.
protocol UserLocalRepositoryProtocol {
    func getUser() async throws -> User
}

struct UserLocalRepository: UserLocalRepositoryProtocol {
    
    func getUser() async throws -> User {
        User.preview
    }
    
}
