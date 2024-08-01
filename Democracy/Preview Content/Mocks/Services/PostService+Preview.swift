//
//  PostService+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/20/24.
//

import Foundation

final class PostServiceMock: PostService {

}

// MARK: - Methods
extension PostServiceMock {
    
    func submitPost(userInput: SubmitPostInput, communityId: String) async throws {
        return
    }
    
    func fetchPostsForCommunity(
        communityId: String,
        filters: [PostFilter],
        paginationOption: CursorPaginationOption
    ) async throws -> [Post] {
        []
    }
}
