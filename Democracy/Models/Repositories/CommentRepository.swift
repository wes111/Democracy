//
//  CommentRepository.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

protocol CommentRepository {
    func submitComment(_ comment: CommentCreationRequest) async throws -> Comment
    func fetchTopLevelComments(for post: Post) async throws -> [Comment]
}

final class CommentRepositoryDefault: CommentRepository {
    @Injected(\.appwriteService) private var appwriteService
    
    func submitComment(_ comment: CommentCreationRequest) async throws -> Comment {
        try await appwriteService.submitComment(comment)
    }
    
    func fetchTopLevelComments(for post: Post) async throws -> [Comment] {
        try await appwriteService.fetchTopLevelComments(for: post)
    }
}
