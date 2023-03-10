//
//  Post.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation

struct Post: Identifiable {
    let id: UUID = UUID()
    let creationDate = Date()
    let title: String
    let subtitle: String
    let body: String
    let comments: [Comment]
    let likeCount: Int = 0
    let superLikeCount: Int = 0
    let creator: Comrade
    let community: Community = Community(name: "Postable Community", foundedDate: Date())
    let tags: [Tag]
    let link: Link?
}

extension Post: Hashable {
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
