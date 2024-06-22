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
    case unsuccessfulDeletion
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

protocol AppwriteService: Sendable {
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
    func isCommunityNameAvailable(_ name: String) async throws -> Bool
    func fetchAllCommunities() async throws -> [Community]
    func fetchUserMemberships(userId: String) async throws -> [Membership]
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment]
    
    func fetchPostsForCommunity(
        communityId: String,
        oldestDate: Date,
        option: CursorPaginationOption
    ) async throws -> [Post]
    
    // Post/Database Methods
    @discardableResult func submitNewPost(_ newPost: PostCreationRequest) async throws -> Post
    @discardableResult func submitCommunity(_ community: CommunityCreationRequest) async throws -> Community
    @discardableResult func joinCommunity(_ membership: MembershipCreationRequest) async throws -> Membership
    func leaveCommunity(_ membership: Membership) async throws
    
    // Functions
    func submitComment(_ comment: CommentCreationRequest) async throws -> Comment
    func voteOnComment(_ commentVote: CommentVoteRequest) async throws -> CommentVote
}

final class AppwriteServiceDefault: AppwriteService {
    private let projectEndpoint = "http://192.168.86.209/v1"
    private let projectID = "65466f560e77e46a903e"
    
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
    
    @discardableResult func submitNewPost(_ newPost: PostCreationRequest) async throws -> Post {
        let document = try await databases.createDocument(
            databaseId: Database.id,
            collectionId: Collection.post.id,
            documentId: ID.unique(),
            data: try newPost.toDictionary()
        )
        return try PostDTO(document.data.toDictionary()).toPost()
    }
    
    func submitCommunity(_ community: CommunityCreationRequest) async throws -> Community {
        let document = try await databases.createDocument(
            databaseId: Database.id,
            collectionId: Collection.community.id,
            documentId: community.name,
            data: try community.toDictionary()
        )
        return try CommunityDTO(document.data.toDictionary()).toCommunity()
    }
    
    func joinCommunity(_ membership: MembershipCreationRequest) async throws -> Membership {
        let document = try await databases.createDocument(
            databaseId: Database.id,
            collectionId: Collection.membership.id,
            documentId: ID.unique(),
            data: try membership.toDictionary()
        )
        return try MembershipDTO(document.data.toDictionary()).toMembership()
    }
    
    func leaveCommunity(_ membership: Membership) async throws {
        let wasSuccessful = try await databases.deleteDocument(
            databaseId: Database.id,
            collectionId: Collection.membership.id,
            documentId: membership.id
        ) 
        guard let wasSuccessful = wasSuccessful as? Bool, wasSuccessful else {
            throw AppwriteServiceError.unsuccessfulDeletion
        }
    }
    
    func isCommunityNameAvailable(_ name: String) async throws -> Bool {
        let response = try await databases.listDocuments(
            databaseId: Database.id,
            collectionId: Collection.community.id,
            queries: [
                Query.equal("$id", value: name)
            ]
        )
        return response.total == 0
    }
    
    // TODO: I don't think we actually want a method that fetches all communities. This is just a starting point.
    func fetchAllCommunities() async throws -> [Community] {
        let documentList = try await databases.listDocuments(
            databaseId: Database.id,
            collectionId: Collection.community.id
        )
        return try documentList.documents.map { try CommunityDTO($0.data.toDictionary()).toCommunity() }
    }
    
    // Fetch a user's memberships in different Communities.
    func fetchUserMemberships(userId: String) async throws -> [Membership] {
        let documentList = try await databases.listDocuments(
            databaseId: Database.id,
            collectionId: Collection.membership.id,
            queries: [
                Query.equal("userId", value: userId)
            ]
        )
        return try documentList.documents.map { try MembershipDTO($0.data.toDictionary()).toMembership() }
    }
    
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] {
        var queries = [Query.limit(FetchLimit.comment.rawValue)]
        
        switch request {
        case .initialRootComments(let postId):
            queries.append(Query.equal("postId", value: postId))
            queries.append(Query.isNull("parentId"))
            
        case .rootComments(let postId, let afterCommentId):
            queries.append(Query.equal("postId", value: postId))
            queries.append(Query.cursorAfter(afterCommentId))
            queries.append(Query.isNull("parentId"))
            
        case .initialChildComments(let parentId):
            queries.append(Query.equal("parentId", value: parentId))
        
        case .childComments(let parentId, let afterCommentId):
            queries.append(Query.equal("parentId", value: parentId))
            queries.append(Query.cursorAfter(afterCommentId))
        }
        
        let documentList = try await databases.listDocuments(
            databaseId: Database.id,
            collectionId: Collection.comment.id,
            queries: queries
        )
        return try documentList.documents.map { try CommentDTO($0.data.toDictionary()).toComment() }
    }
    
    func fetchPostsForCommunity(communityId: String, oldestDate: Date, option: CursorPaginationOption) async throws -> [Post] {
        
        let cursorQuery: String? = switch option {
        case .after(let id): Query.cursorAfter(id)
        case .before(let id): Query.cursorBefore(id)
        case .initial: nil
        }
        
        var queries = [
            Query.equal("communityId", value: communityId),
            Query.greaterThanEqual("approvedDate", value: oldestDate.ISO8601Format()),
            Query.limit(25)
        ]
        
        if let cursorQuery {
            queries.append(cursorQuery)
        }
        
        let documentList = try await databases.listDocuments(
            databaseId: Database.id,
            collectionId: Collection.post.id,
            queries: queries
        )
        return try documentList.documents.map { try PostDTO($0.data.toDictionary()).toPost() }
    }
    
    func submitComment(_ comment: CommentCreationRequest) async throws -> Comment {
        let jsonString = try comment.toJSONString()
        
        let execution = try await functions.createExecution(
            functionId: AppwriteFunction.postComment.id,
            body: jsonString,
            method: AppwriteMethod.post.name
        )
        let response: CommentDTO = try execution.responseBody.decode()
        return response.toComment()
    }
    
    func voteOnComment(_ commentVote: CommentVoteRequest) async throws -> CommentVote {
        let jsonString = try commentVote.toJSONString()
        
        let execution = try await functions.createExecution(
            functionId: AppwriteFunction.voteComment.id,
            body: jsonString,
            method: AppwriteMethod.post.name
        )
        
        let response: CommentVoteDTO = try execution.responseBody.decode()
        return response.toCommentVote()
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
            functionId: AppwriteFunction.uniqueAccountFieldIsAvailable.id,
            body: jsonString,
            method: AppwriteMethod.get.name
        )
        let isAvailable: UniqueAccountFieldAvailable = try execution.responseBody.decode()
        return isAvailable.isAvailable
    }
}

enum FetchLimit: Int {
    case comment = 25
}

enum AppwriteMethod: String {
    case get
    case post
    
    var name: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        }
    }
}

enum AppwriteFunction: String {
    case postComment
    case voteComment
    case uniqueAccountFieldIsAvailable = "UniqueAccountFieldIsAvailable"
    
    var id: String {
        self.rawValue
    }
}

enum CommentFetchRequest {
    case initialRootComments(postId: String)
    case rootComments(postId: String, afterCommentId: String)
    case initialChildComments(parentId: String)
    case childComments(parentId: String, afterCommentId: String)
}
