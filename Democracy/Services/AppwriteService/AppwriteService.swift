//
//  AppwriteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/27/23.
//

import Appwrite
import Foundation

struct PhoneNumber {
    let countryCode: Int = 1 // Single digit? What are the possible values here
    let base: Int //10 digit number?
    
    init(base: Int) {
        self.base = base
    }
    
    var appwriteString: String {
        "+\(countryCode)\(base)"
    }
}

struct Token {
    let id: String
    let userID: String
    let createdAt: Date?
    let expiresAt: Date?
}

protocol AppwriteService {
    func createUser(userName: String, password: String, email: String) async throws -> User
    func login(email: String, password: String) async throws
    func logout(sessionID: String) async throws
    func updatePhone(phone: PhoneNumber, password: String) async throws -> User
    func createPhoneVerification() async throws -> Token
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
    
    func createUser(userName: String, password: String, email: String) async throws -> User {
        let appwriteUser = try await account.create(
            userId: userName,
            email: email,
            password: password
        )
        print(appwriteUser)
        return appwriteUser.toUser()
    }
    
    func login(email: String, password: String) async throws {
        let session = try await account.createEmailSession(
            email: email,
            password: password
        )
        //TODO: Do something with the session
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws -> User {
        let user = try await account.updatePhone(phone: phone.appwriteString, password: password)
        return user.toUser()
    }
    
    func createPhoneVerification() async throws -> Token {
        let token = try await account.createPhoneVerification()
        return token.toToken()
    }
    
    func logout(sessionID: String) async throws {
        //TODO: ...
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

extension Appwrite.Token {
    func toToken() -> Token {
        let formatter = ISO8601DateFormatter.sharedWithFractionalSeconds
        
        return .init(
            id: id,
            userID: userId,
            createdAt: formatter.date(from: createdAt),
            expiresAt: formatter.date(from: expire)
        )
    }
}

extension Appwrite.Session {
//    func toSession() -> Session {
//
//    }
}
