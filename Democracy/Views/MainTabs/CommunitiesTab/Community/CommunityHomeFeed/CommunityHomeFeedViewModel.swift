//
//  CommunityHomeFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Foundation
import Factory

protocol CommunityHomeFeedCoordinatorDelegate: PostCardCoordinatorDelegate {
    var community: Community { get }
}

protocol CommunityHomeFeedViewModelProtocol: ObservableObject {
    var posts: [Post] { get }
    var coordinator: CommunityHomeFeedCoordinatorDelegate { get }
    
    func goToPost()
    func refreshPosts()
    func getPostCardViewModel(post: Post) -> PostCardViewModel
}

final class CommunityHomeFeedViewModel: CommunityHomeFeedViewModelProtocol {
    
    @Injected(\.postInteractor) var postInteractor
    
    @Published var posts: [Post] = []
    
    let coordinator: CommunityHomeFeedCoordinatorDelegate
    
    func getPostCardViewModel(post: Post) -> PostCardViewModel {
        PostCardViewModel(coordinator: coordinator, post: post)
    }
    
    init(coordinator: CommunityHomeFeedCoordinatorDelegate
    ) {
        self.coordinator = coordinator
        postInteractor.subscribeToPosts().assign(to: &$posts)
    }
    
    func goToPost() {
        coordinator.goToPostView(Post.preview)
    }
    
    func refreshPosts() {
        postInteractor.refreshPosts()
    }
    
}

