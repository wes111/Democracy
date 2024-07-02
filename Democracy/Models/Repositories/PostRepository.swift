//
//  PostRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/6/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

protocol PostRepository {
    func submitPost(_ newPost: PostCreationRequest) async throws
    
    func fetchPostsForCommunity(
        communityId: String,
        oldestDate: Date,
        option: CursorPaginationOption
    ) async throws -> [Post]
}

final class PostRepositoryDefault: PostRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func submitPost(_ newPost: PostCreationRequest) async throws {
        try await appwriteService.submitNewPost(newPost)
    }
    
    func fetchPostsForCommunity(
        communityId: String,
        oldestDate: Date,
        option: CursorPaginationOption
    ) async throws -> [Post] {
        try await appwriteService.fetchPostsForCommunity(
            communityId: communityId,
            oldestDate: oldestDate,
            option: option
        )
    }
}
