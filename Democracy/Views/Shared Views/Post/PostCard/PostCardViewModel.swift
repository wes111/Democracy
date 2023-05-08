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
    var post: Post { get }
    func goToPostView()
    func noAction()
}

final class PostCardViewModel: PostCardViewModelProtocol {
    
    private let coordinator: PostCardCoordinatorDelegate
    let post: Post
    
    init(coordinator: PostCardCoordinatorDelegate,
         post: Post
    ) {
        self.coordinator = coordinator
        self.post = post
    }
    
    func goToPostView() {
        coordinator.goToPostView(post)
    }
    
    func noAction() {
        print("No Action.")
    }
    
}
