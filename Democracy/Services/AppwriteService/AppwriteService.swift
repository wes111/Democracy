//
//  AppwriteService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/27/23.
//

import Appwrite
import Foundation
import SharedResourcesClientAndServer

// TODO: This is an open Appwrite feature: https://github.com/appwrite/sdk-generator/issues/698
enum AppwriteError: String, Error {
    case noSession = "User (role: guests) missing scope (account)"
    case userNotFoundError = "User with the requested ID could not be found."
}

enum AppwriteServiceError: Error {
    case badCreationDate
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
    // Account Methods
    func createUser(userName: String, password: String, email: String)
        async throws -> SharedResourcesClientAndServer.User
    func login(email: String, password: String) async throws -> Session
    func logout(sessionId: String) async throws
    func getCurrentSession() async throws -> Session
    func updatePhone(phone: PhoneNumber, password: String) 
        async throws -> SharedResourcesClientAndServer.User
    func getCurrentLoggedInUser() async throws -> SharedResourcesClientAndServer.User
    
    func getUserNameAvailable(username: String) async throws -> Bool
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool
    func getEmailAvailable(_ email: String) async throws -> Bool
    
    // Post/Database Methods
    @discardableResult func submitNewPost(_ newPost: PostDTO) async throws -> Post
    @discardableResult func submitCommunity(_ community: CommunityCreationRequest) async throws -> Community
}

final class AppwriteServiceDefault: AppwriteService {
    private let projectEndpoint = "http://192.168.86.106/v1"
    private let projectID = "65466f560e77e46a903e"
    private let databaseId = "65956325b9edac11832a"
    private let postCollectionId = "6595636e9fae941f4374"
    private let communityCollectionId = "65980c47b96a51cbd280"
    
    private lazy var client: Client = {
        Client()
            .setEndpoint(projectEndpoint)
            .setProject(projectID)
            .setSelfSigned(true) // For self signed certificates, only use for development
    }()
    
    private lazy var databases = {
        Databases(client)
    }()
    
    private lazy var account: Account = {
        Account(client)
    }()
    
    private lazy var functions: Functions = {
        Functions(client)
    }()
}

// MARK: - Methods
extension AppwriteServiceDefault {
    
    func createUser(userName: String, password: String, email: String)
        async throws -> SharedResourcesClientAndServer.User {
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
    
    func updatePhone(phone: PhoneNumber, password: String) 
        async throws -> SharedResourcesClientAndServer.User {
        try await account.updatePhone(phone: phone.appwriteString, password: password).toUser()
    }
    
    func getCurrentLoggedInUser() async throws -> SharedResourcesClientAndServer.User {
        try await account.get().toUser()
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        try await getUniqueAccountFieldAvailable(.phone, value: phone.appwriteString)
    }
    
    func getUserNameAvailable(username: String) async throws -> Bool {
        try await getUniqueAccountFieldAvailable(.username, value: username)
    }
    
    func getEmailAvailable(_ email: String) async throws -> Bool {
        let newEmail = "\"\(email)\""
        return try await getUniqueAccountFieldAvailable(.email, value: newEmail)
    }
}

// MARK: - Post/Database Methods
extension AppwriteServiceDefault {
    
    @discardableResult func submitNewPost(_ newPost: PostDTO) async throws -> Post {
        let document = try await databases.createDocument(
            databaseId: databaseId,
            collectionId: postCollectionId,
            documentId: ID.unique(),
            data: try newPost.toDictionary()
        )
        return try Post(document.data.toDictionary())
    }
    
    func submitCommunity(_ community: CommunityCreationRequest) async throws -> Community {
        let document = try await databases.createDocument(
            databaseId: databaseId,
            collectionId: communityCollectionId,
            documentId: community.name,
            data: try community.toDictionary()
        )
        return try CommunityDTO(document.data.toDictionary()).toCommunity()
    }
    
}

// MARK: - Private Methods
private extension AppwriteServiceDefault {
    func getUniqueAccountFieldAvailable(_ field: UniqueAccountField, value: String) async throws -> Bool {
        let jsonString = try UniqueAccountFieldRequest(
            field: field,
            value: value
        ).toJSONString()
        
        let execution = try await functions.createExecution(
            functionId: "UniqueAccountFieldIsAvailable",
            body: jsonString,
            method: "GET"
        )
        let isAvailable: UniqueAccountFieldAvailable = try execution.responseBody.decode()
        return isAvailable.isAvailable
    }
}
