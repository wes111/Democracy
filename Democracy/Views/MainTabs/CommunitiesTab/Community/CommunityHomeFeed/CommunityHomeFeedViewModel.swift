//
//  CommunityHomeFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Foundation

protocol CommunityHomeFeedCoordinatorDelegate: PostCardCoordinatorDelegate {
}

protocol CommunityHomeFeedViewModelProtocol: ObservableObject {
    var posts: [Post] { get }
    var coordinator: CommunityHomeFeedCoordinatorDelegate { get }
    func goToPost()
}

final class CommunityHomeFeedViewModel: CommunityHomeFeedViewModelProtocol {
    
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
    
}

