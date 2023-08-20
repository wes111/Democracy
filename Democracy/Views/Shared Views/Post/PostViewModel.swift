//
//  PostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation

protocol PostCoordinatorDelegate {
}

protocol PostViewModelProtocol: ObservableObject, Identifiable {
    var post: Post { get }
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
    
}

