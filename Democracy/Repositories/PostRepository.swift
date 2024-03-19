//
//  PostRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/6/24.
//

import Factory
import Foundation

protocol PostRepository {
    func submitPost(_ newPost: PostCreationRequest) async throws
}

final class PostRepositoryDefault: PostRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func submitPost(_ newPost: PostCreationRequest) async throws {
        try await appwriteService.submitNewPost(newPost)
    }
}
