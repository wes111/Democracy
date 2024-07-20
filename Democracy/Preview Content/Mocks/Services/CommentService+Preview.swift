//
//  CommentService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation

final class CommentServiceMock: CommentService {

}

// MARK: - Methods
extension CommentServiceMock {
    
    func submitComment(parentId: String?, postId: String, content: String) async throws -> Comment {
        .preview
    }
    
    func fetchComments(request: CommentFetchRequest) async throws -> [Comment] {
        []
    }
}
