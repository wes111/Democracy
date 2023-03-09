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
    func goToPost()
}

final class CommunityHomeFeedViewModel: CommunityHomeFeedViewModelProtocol {

    private let coordinator: CommunityHomeFeedCoordinatorDelegate
    
    init(coordinator: CommunityHomeFeedCoordinatorDelegate
    ) {
        self.coordinator = coordinator
    }
    
    func goToPost() {
        coordinator.goToPostView(Post(title: "Test Post", body: "Test Post body."))
    }
    
}

