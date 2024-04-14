//
//  CommunityHomeFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Combine
import Foundation
import Factory

@MainActor @Observable
final class CommunityHomeFeedViewModel {
    var posts: [PostCardViewModel] = Post.previewArray.map { $0.toViewModel(coordinator: nil) }
    
    @ObservationIgnored private weak var coordinator: CommunitiesCoordinatorDelegate?

    init(coordinator: CommunitiesCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
}

// MARK: - Methods
extension CommunityHomeFeedViewModel {
    
    func getPostCardViewModel(post: Post) -> PostCardViewModel {
        PostCardViewModel(coordinator: coordinator, post: post)
    }
    
    func goToPost() {
        coordinator?.goToPostView(Post.preview)
    }
    
    func refreshPosts() {
        //postInteractor.refreshPosts()
    }
}
