//
//  AppwriteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/27/23.
//

import Appwrite
import Foundation

protocol AppwriteService {
    func createUser() async throws -> User
}

//TODO: There is info that must be added to get the OAuth callback (see website).
final class AppwriteServiceDefault: AppwriteService {
    
    private let client: Client
    private let account: Account
    
    init() {
        client = Client()
            .setEndpoint("http://192.168.86.250/v1")
            .setProject("6510765aeda81a163169")
            .setSelfSigned(true) // For self signed certificates, only use for development
        
        account = Account(client)
    }
    
    func createUser() async throws -> User {
        let appwriteUser = try await account.create(
            userId: "123",
            email: "",
            password: "")
        return appwriteUser.toUser()
    }
}

enum TodoError: Error {
    case unexpected
}

extension Appwrite.User {
    
    func toUser() -> User {
        let formatter = ISO8601DateFormatter.sharedWithFractionalSeconds
        
        return .init(
            accessedAt: formatter.date(from: accessedAt),
            createdAt: formatter.date(from: createdAt),
            email: email,
            emailVerification: emailVerification,
            id: id,
            labels: [],
            name: name,
            passwordUpdate: formatter.date(from: passwordUpdate),
            phone: phone,
            phoneVerification: phoneVerification,
            prefs: [],
            registration: formatter.date(from: registration),
            status: status,
            updatedAt: formatter.date(from: updatedAt)
        )
    }
}
