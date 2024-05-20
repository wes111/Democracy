//
//  PostViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import Foundation
import Factory

// TODO: This is tempory. DELETE later.
extension Comment {
    init(value: String) {
        id = value
        parentId = value
        postId = value
        userId = "Bernie Sanders"
        creationDate = .now
        content = value
        upVoteCount = 10
        downVoteCount = 2
        responseCount = 3
    }
}

protocol PostCoordinatorDelegate: AnyObject {
    func goBack()
}

@MainActor @Observable
final class PostViewModel {

    private weak var coordinator: PostCoordinatorDelegate?
    @ObservationIgnored @Injected(\.commentService) private var commentService
    
    let post: Post
    let testComments: [Node<Comment>] = [
        .init(
            value: .init(value: "1: In the ethereal twilight of a summer evening, fireflies danced in the warm breeze, casting their fleeting glow upon the verdant meadows."),
            children: [
                .init(value: .init(value: "2: In the ethereal twilight of a summer evening, fireflies danced in the warm breeze, casting their fleeting glow upon the verdant meadows."), children: [
                    .init(value: .init(value: "3: In the ethereal twilight of a summer evening, fireflies danced in the warm breeze, casting their fleeting glow upon the verdant meadows.")),
                    .init(value: .init(value: "4: In the ethereal twilight of a summer evening, fireflies danced in the warm breeze, casting their fleeting glow upon the verdant meadows."))
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

// MARK: - Methods
extension PostViewModel {
    func test() {
        Task {
            do {
                try await commentService.submitComment(parentId: "664a6a4a582f78b81b19", postId: "123", content: "rts")
            } catch {
                print(error)
                print()
            }
        }
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
