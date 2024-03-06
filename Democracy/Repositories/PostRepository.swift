//
//  PostRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/6/24.
//

import Factory
import Foundation

protocol PostRepository {
    func submitPost(_ newPost: PostDTO) async throws
}

final class PostRepositoryDefault: PostRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func submitPost(_ newPost: PostDTO) async throws {
        try await appwriteService.submitNewPost(newPost)
    }
}
