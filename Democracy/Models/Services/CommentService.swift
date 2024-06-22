//
//  CommentService.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/12/24.
//

import Factory
import Foundation
import SharedResourcesClientAndServer

protocol CommentService: Sendable {
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment]
    func voteOnComment(commentId: String, vote: VoteType) async throws -> CommentVote
}

final class CommentServiceDefault: CommentService {
    @Injected(\.commentRepository) private var commentRepository
    @Injected(\.userRepository) private var userRepository
    
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment {
        try await commentRepository.submitComment(.init(
            parentId: parentId,
            postId: postId,
            userId: try await userRepository.userId(),
            content: content
        ))
    }
    
    func voteOnComment(commentId: String, vote: VoteType) async throws -> CommentVote {
        try await commentRepository.voteOnComment(request: .init(
            commentId: commentId,
            userId: try await userRepository.userId(),
            vote: vote
        ))
    }
    
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] {
        try await commentRepository.fetchComments(request: request)
    }
}
