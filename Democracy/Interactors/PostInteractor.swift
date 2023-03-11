//
//  PostInteractor.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation
import Factory

protocol PostInteractorProtocol {
    func getPosts()
    func refreshPosts()
}

struct PostInteractor: PostInteractorProtocol {
    
    @Injected(\.postLocalRepository) var localRepository
    @Injected(\.postRemoteRepository) var remoteRepository
    
    init() {
        
    }
    
    func getPosts() {
        print("get Posts.")
    }
    
    func refreshPosts() {
        print("refresh Posts.")
    }
    
}
