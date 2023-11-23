//
//  AppwriteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/27/23.
//

import Appwrite
import Foundation
import SharedResourcesClientAndServer

struct PhoneNumber {
    let countryCode: Int = 1 // Single digit? What are the possible values here
    let base: Int // 10 digit number?
    
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
    func login(email: String, password: String) async throws -> Session
    func logout(sessionId: String) async throws
    func getCurrentSession() async throws -> Session
    func updatePhone(phone: PhoneNumber, password: String) async throws -> User
    func createPhoneVerification() async throws -> Token
    func createEmailVerification() async throws -> Token
    
    func getUserNameAvailable(username: String) async throws -> Bool
}

// TODO: There is info that must be added to get the OAuth callback (see website).
final class AppwriteServiceDefault: AppwriteService {
    
    private let projectEndpoint = "http://192.168.86.231/v1"
    private let projectID = "65466f560e77e46a903e"
    
    private lazy var client: Client = {
        Client()
            .setEndpoint(projectEndpoint)
            .setProject(projectID)
            .setSelfSigned(true) // For self signed certificates, only use for development
    }()
    
    private lazy var account: Account = {
        Account(client)
    }()
    
    private lazy var functions: Functions = {
        Functions(client)
    }()
    
    init() {}
    
    func getUserNameAvailable(username: String) async throws -> Bool {
        let usernameJSONString = try Username(userName: username).toJSONString()
        let execution = try await functions.createExecution(
            functionId: "usernameAvailable",
            body: usernameJSONString,
            method: "GET"
        )
        let response: UsernameAvailable = try execution.responseBody.decode()
        return response.isAvailable
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
    
    func login(email: String, password: String) async throws -> Session {
        try await account.createEmailSession(email: email, password: password).toSession()
    }
    
    func logout(sessionId: String) async throws {
        _ = try await account.deleteSession(sessionId: sessionId)
    }
    
    func getCurrentSession() async throws -> Session {
        try await account.getSession(sessionId: "current").toSession()
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws -> User {
        let user = try await account.updatePhone(phone: phone.appwriteString, password: password)
        return user.toUser()
    }
    
    func createPhoneVerification() async throws -> Token {
        let token = try await account.createPhoneVerification()
        return token.toToken()
    }
    
    func createEmailVerification() async throws -> Token {
        return .init(id: "", userID: "", createdAt: .now, expiresAt: .now)
        //        let appwriteToken = try await account.createVerification(url: "http://192.168.86.244/")
        //        return appwriteToken.toToken()
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
