//
//  PostService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/3/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

enum PostServiceError: Error {
    case userAccountMissing
    case invalidUserInput
}

protocol PostService: Sendable {
    func submitPost(userInput: SubmitPostInput, communityId: String) async throws
    
    func fetchPostsForCommunity(
        communityId: String,
        filters: [PostFilter],
        paginationOption: CursorPaginationOption
    ) async throws -> [Post]
}

final class PostServiceDefault: PostService {
    @Injected(\.postRepository) private var postRepository
    @Injected(\.userRepository) private var userRepository
    
    func submitPost(userInput: SubmitPostInput, communityId: String) async throws {
        guard let title = userInput.title, let body = userInput.body, let category = userInput.category else {
            throw PostServiceError.invalidUserInput
        }
        
        try await postRepository.submitPost(.init(
            title: title,
            body: body,
            link: userInput.primaryLink,
            categoryName: category,
            tagIds: userInput.tags.map { $0.id },
            communityTagsString: userInput.tags.map { $0.name }.joined(separator: ", "), // TODO: Should only be on backend, see note in Shared...
            userId: try await userRepository.userId(),
            communityId: communityId
        ))
    }
    
    func fetchPostsForCommunity(
        communityId: String,
        filters: [PostFilter],
        paginationOption: CursorPaginationOption
    ) async throws -> [Post] {
        try await postRepository.fetchPostsForCommunity(
            communityId: communityId,
            filters: filters,
            paginationOption: paginationOption
        )
    }
}
