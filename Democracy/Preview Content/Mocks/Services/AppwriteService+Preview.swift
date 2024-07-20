//
//  AppwriteService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation
import SharedResourcesClientAndServer

final class AppwriteServiceMock: AppwriteService {

}

// MARK: - Methods
extension AppwriteServiceMock {
    
    func createUser(userName: String, password: String, email: String) async throws -> User {
        .preview
    }
    
    func login(email: String, password: String) async throws -> Session {
        .preview
    }
    
    func logout(sessionId: String) async throws {
        return
    }
    
    func getCurrentSession() async throws -> Session {
        .preview
    }
    
    func updatePhone(phone: PhoneNumber, password: String) async throws -> User {
        .preview
    }
    
    func getCurrentLoggedInUser() async throws -> User {
        .preview
    }
    
    func getUserNameAvailable(username: String) async throws -> Bool {
        false
    }
    
    func getPhoneIsAvailable(_ phone: PhoneNumber) async throws -> Bool {
        false
    }
    
    func getEmailAvailable(_ email: String) async throws -> Bool {
        false
    }
    
    func isCommunityNameAvailable(_ name: String) async throws -> Bool {
        false
    }
    
    func fetchAllCommunities() async throws -> [Community] {
        []
    }
    
    func fetchUserMemberships(userId: String) async throws -> [Membership] {
        []
    }
    
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] {
        []
    }
    
    func fetchPostsForCommunity(
        communityId: String,
        query: PostsQuery,
        option: CursorPaginationOption
    ) async throws -> [Post] {
        []
    }
    
    func submitNewPost(_ newPost: PostCreationRequest) async throws -> Post {
        .preview
    }
    
    func submitCommunity(_ community: CommunityCreationRequest) async throws -> Community {
        .preview
    }
    
    func joinCommunity(_ membership: MembershipCreationRequest) async throws -> Membership {
        .preview
    }
    
    func leaveCommunity(_ membership: Membership) async throws {
        return
    }
    
    func submitComment(_ comment: CommentCreationRequest) async throws -> Comment {
        .preview
    }
    
    func voteOnComment(_ commentVote: CommentVoteRequest) async throws -> CommentVote {
        .preview
    }
    
    func voteOnPost(_ postVote: PostVoteRequest) async throws -> PostVote {
        .preview
    }
}
