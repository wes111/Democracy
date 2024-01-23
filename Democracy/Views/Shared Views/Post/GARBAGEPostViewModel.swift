//
//  PostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation

protocol PostCoordinatorDelegate: AnyObject {
}

protocol PostViewModelProtocol: ObservableObject, Identifiable {
    var post: Post { get }
}

final class GARBAGEPostViewModel: PostViewModelProtocol {

    // private weak var coordinator: PostCoordinatorDelegate?
    let post: Post
    
    init(// coordinator: PostCoordinatorDelegate?,
         post: Post
    ) {
        // self.coordinator = coordinator
        self.post = post
    }
}
