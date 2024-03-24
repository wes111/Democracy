//
//  PostInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Combine
import Factory

protocol PostInteractorProtocol {
    func subscribeToPosts() -> AnyPublisher<[Post], Never>
    func refreshPosts()
    func submitPost() async throws
}

struct PostInteractor: PostInteractorProtocol {
    
    //@Injected(\.postLocalRepository) var localRepository
    
    private var postsPublisher = PassthroughSubject<[Post], Never>()
    
    init() {
        
    }
    
    func subscribeToPosts() -> AnyPublisher<[Post], Never> {
        postsPublisher.eraseToAnyPublisher()
    }
    
    func refreshPosts() {
        postsPublisher.send(Post.previewArray)
    }
    
    func submitPost() async throws {
        try? await Task.sleep(nanoseconds: UInt64(3 * 1E9))
        print("Post submitted")
    }
    
}
