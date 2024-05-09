//
//  PostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation
import Factory

extension Comment {
    init(value: String) {
        id = value
        parentId = value
        postId = value
        userId = value
        creationDate = .now
        content = value
    }
}

protocol PostCoordinatorDelegate: AnyObject {
    func goBack()
}

@MainActor @Observable
final class PostViewModel {

    private weak var coordinator: PostCoordinatorDelegate?
    let post: Post
    let testComments: [Node<Comment>] = [
        .init(
            value: .init(value: "Hello World!"),
            children: [
                .init(value: .init(value: "My Name is Jesus"), children: [
                    .init(value: .init(value: "My name is God")),
                    .init(value: .init(value: "My name is the Holy Ghost"))
                ]),
                .init(value: .init(value: "My Name is Rudy"))
            ]
        ),
        
        .init(
            value: .init(value: "Hello World 2!"),
            children: [
                .init(value: .init(value: "Comment 1")),
                .init(value: .init(value: "Comment 2"))
            ]
        )
    ]
    
    init(coordinator: PostCoordinatorDelegate?, post: Post) {
        self.coordinator = coordinator
        self.post = post
    }
}

// MARK: - Computed Properties
extension PostViewModel {
    
    var leadingContent: [TopBarContent] {
        [.back(goBack)]
    }
    
    var centerContent: [TopBarContent] {
        [.title("Todo - Title")]
    }
    
    var trailingContent: [TopBarContent] {
        [.menu([])]
    }
}

private extension PostViewModel {
    
    func goBack() {
        coordinator?.goBack()
    }
}

final class CommentsManager {
    
    private var rootComments: [Node<Comment>] = []
}
