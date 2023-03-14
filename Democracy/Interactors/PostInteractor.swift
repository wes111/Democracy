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
}

struct PostInteractor: PostInteractorProtocol {
    
    @Injected(\.postLocalRepository) var localRepository
    @Injected(\.postRemoteRepository) var remoteRepository
    
    private var postsPublisher = PassthroughSubject<[Post], Never>()
    
    init() {
        
    }
    
    func subscribeToPosts() -> AnyPublisher<[Post], Never> {
        postsPublisher.eraseToAnyPublisher()
    }
    
    func refreshPosts() {
        postsPublisher.send(Post.previewArray)
    }
    
}
