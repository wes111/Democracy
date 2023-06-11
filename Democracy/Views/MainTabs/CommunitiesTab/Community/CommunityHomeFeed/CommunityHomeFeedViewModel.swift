//
//  CommunityHomeFeedViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/8/23.
//

import Combine
import Foundation
import Factory

protocol CommunityHomeFeedCoordinatorDelegate: PostCardCoordinatorDelegate {
    var community: Community { get }
}

final class CommunityHomeFeedViewModel: ObservableObject {
    
    @Injected(\.postInteractor) var postInteractor
    
    @Published var posts: [Post] = []
    @Published var scrollOffset = CGPoint(x: 0, y: 0)

    private var cancellables = Set<AnyCancellable>()
    
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
    
    // Returns an array of dates the user initially sees on this tab, currently last 7 days.
    lazy var initialDates: [Date] = {
        var days: [Date] = []
        for dayOfWeekCount in 0...6 {
            let date = Date.previousDay(offset: dayOfWeekCount)
            days.append(date)
        }
        return days
    }()
    
    lazy var pinnedPosts: [PostCardViewModel] = {
        PostCardViewModel.previewArray
    }()
    
    // TODO: ...
    func topPostsForDate(_ date: Date) -> [PostCardViewModel] {
        // Tapping a post card doesn't do anything currently because we're using this privew here. TODO: ...
        PostCardViewModel.previewArray
    }
    
}

