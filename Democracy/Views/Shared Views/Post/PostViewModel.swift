//
//  PostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation

protocol PostCoordinatorDelegate {
    func go()
}

protocol PostViewModelProtocol: ObservableObject {
    var post: Post { get }
    func go()
}

final class PostViewModel: PostViewModelProtocol {

    private let coordinator: PostCoordinatorDelegate
    let post: Post
    
    init(coordinator: PostCoordinatorDelegate,
         post: Post
    ) {
        self.coordinator = coordinator
        self.post = post
    }
    
    func go() {
        coordinator.go()
    }
    
}

