//
//  PostService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/3/24.
//

import Factory
import Foundation

enum PostServiceError: Error {
    case userAccountMissing
    case invalidUserInput
}

protocol PostService: Sendable {
    func submitPost(userInput: SubmitPostInput, communityId: String) async throws
    
    func fetchPostsForCommunity(
        communityId: String,
        oldestDate: Date,
        option: CursorPaginationOption
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
            category: category,
            tags: Array(userInput.tags),
            userId: try await userRepository.userId(),
            communityId: communityId
        ))
    }
    
    func fetchPostsForCommunity(
        communityId: String,
        oldestDate: Date,
        option: CursorPaginationOption
    ) async throws -> [Post] {
        try await postRepository.fetchPostsForCommunity(
            communityId: communityId,
            oldestDate: oldestDate,
            option: option
        )
    }
}
