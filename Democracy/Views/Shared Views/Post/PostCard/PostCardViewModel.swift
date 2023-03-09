//
//  PostCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Foundation

protocol PostCardCoordinatorDelegate {
    func goToPostView(_ post: Post)
}

protocol PostCardViewModelProtocol: ObservableObject {
    func goToPostView(_ post: Post)
}

final class PostCardViewModel: PostCardViewModelProtocol {
    
    private let coordinator: PostCardCoordinatorDelegate
    private let post: Post
    
    init(coordinator: PostCardCoordinatorDelegate,
         post: Post
    ) {
        self.coordinator = coordinator
        self.post = post
    }
    
    func goToPostView(_ post: Post) {
        coordinator.goToPostView(post)
    }
    
}
