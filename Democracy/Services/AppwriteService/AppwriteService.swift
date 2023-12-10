//
//  AppwriteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/27/23.
//

import Appwrite
import Foundation
import SharedResourcesClientAndServer

// TODO: Move this to the shared client/server package.
// TODO: This is an open Appwrite feature: https://github.com/appwrite/sdk-generator/issues/698
enum AppwriteError: String, Error {
    case noSession = "User (role: guests) missing scope (account)"
    case userNotFoundError = "User with the requested ID could not be found."
}

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
    func createUser(userName: String, password: String, email: String) async throws -> SharedResourcesClientAndServer.User
    func login(email: String, password: String) async throws -> Session
    func logout(sessionId: String) async throws
    func getCurrentSession() async throws -> Session
    func updatePhone(phone: PhoneNumber, password: String) async throws -> SharedResourcesClientAndServer.User
    func getCurrentLoggedInUser() async throws -> SharedResourcesClientAndServer.User
    
    func getUserNameAvailable(username: String) async throws -> Bool
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool
}

// TODO: There is info that must be added to get the OAuth callback (see website).
final class AppwriteServiceDefault: AppwriteService {
    
    private let projectEndpoint = "http://192.168.86.31/v1"
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
    
    func createUser(userName: String, password: String, email: String) async throws -> SharedResourcesClientAndServer.User {
        let appwriteUser = try await account.create(
            userId: userName,
            email: email,
            password: password
        )
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
    
    func updatePhone(phone: PhoneNumber, password: String) async throws -> SharedResourcesClientAndServer.User {
        try await account.updatePhone(phone: phone.appwriteString, password: password).toUser()
    }
    
    func getCurrentLoggedInUser() async throws -> SharedResourcesClientAndServer.User {
        try await account.get().toUser()
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        let phoneJSONString = try Phone(phone: phone.appwriteString).toJSONString()
        let execution = try await functions.createExecution(
            functionId: "getUserByPhone",
            body: phoneJSONString,
            method: "GET"
        )
        let users: UsersList = try execution.responseBody.decode()
        return users.list.isEmpty
    }
}
