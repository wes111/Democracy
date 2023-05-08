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
    
    func topPostsForDate(_ date: Date) -> [PostCardViewModel]
    var pinnedPosts: [PostCardViewModel] { get }
    var initialDates: [Date] { get }
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

