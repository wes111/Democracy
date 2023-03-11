//
//  CommunityHomeFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Foundation
import Factory

protocol CommunityHomeFeedCoordinatorDelegate: PostCardCoordinatorDelegate {
}

protocol CommunityHomeFeedViewModelProtocol: ObservableObject {
    var posts: [Post] { get }
    var coordinator: CommunityHomeFeedCoordinatorDelegate { get }
    
    func goToPost()
    func refreshPosts()
}

final class CommunityHomeFeedViewModel: CommunityHomeFeedViewModelProtocol {
    
    @Injected(\.postInteractor) var postInteractor
    
    @Published var posts: [Post] = [
        Post.preview
    ]
    
    let coordinator: CommunityHomeFeedCoordinatorDelegate
    
    init(coordinator: CommunityHomeFeedCoordinatorDelegate
    ) {
        self.coordinator = coordinator
    }
    
    func goToPost() {
        coordinator.goToPostView(Post.preview)
    }
    
    func refreshPosts() {
        postInteractor.refreshPosts()
    }
    
}

