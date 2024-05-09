//
//  Comment.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/9/23.
//

import Foundation

// Domain model
struct Comment: Identifiable, Hashable {
    let id: String
    let parentId: String?
    let postId: String
    let userId: String
    let creationDate: Date
    let content: String
}

// The Comment object received from the Appwrite database.
struct CommentDTO: Decodable {
    let id: String
    let parentId: String?
    let postId: String
    let userId: String
    let creationDate: DateWrapper
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case parentId, postId, userId, content
        case id = "$id"
        case creationDate = "$createdAt"
    }
    
    func toComment() -> Comment {
        .init(
            id: id,
            parentId: parentId,
            postId: postId,
            userId: userId,
            creationDate: creationDate.date,
            content: content
        )
    }
}

// The Comment object sent to the Appwrite database.
struct CommentCreationRequest: Encodable {
    let parentId: String?
    let postId: String
    let userId: String
    let content: String
}
