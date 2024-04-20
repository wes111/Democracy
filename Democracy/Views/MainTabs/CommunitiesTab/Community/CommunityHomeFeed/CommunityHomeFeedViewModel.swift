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
    var posts: [Post] = []
    var scrollId: Post?
    var isShowingTopProgress: Bool = true
    var isShowingBottomProgress: Bool = false
    
    @ObservationIgnored @Injected(\.postService) private var postService
    @ObservationIgnored private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    // We use these variables to determine if the last/first post in the database is in memory.
    // If it is, then we do not need to try to fetch any more posts from the database.
    @ObservationIgnored private var lastPostInDatabase: Post?
    @ObservationIgnored private var firstPostInDatabase: Post?
    
    private static let maxInMemoryPostCount = 50
    private static let pageCount = 25
    
    // TODO: Should this be a community setting? To choose how old of posts are displayed? day, month, year, etc...
    private let oldestFeedDate = Date.now
    private let community: Community
    
    init(community: Community, coordinator: CommunitiesCoordinatorDelegate?) {
        self.community = community
        self.coordinator = coordinator
        
        Task {
            await refreshPosts()
        }
    }
}

// MARK: - Methods
extension CommunityHomeFeedViewModel {
    
    func onAppear(_ post: Post) async {
        if post == posts.last {
            await fetchNextPage()
        } else if post == posts.first {
            await fetchPreviousPage()
        }
    }
    
    func postShouldShowBottomProgress(_ post: Post) -> Bool {
        isShowingBottomProgress && (post == posts.last)
    }
    
    func postShouldShowTopProgress(_ post: Post) -> Bool {
        isShowingTopProgress && (post == posts.first)
    }
    
    func getPostCardViewModel(post: Post) -> PostCardViewModel {
        PostCardViewModel(coordinator: coordinator, post: post)
    }
    
    func goToPost() {
        coordinator?.goToPostView(Post.preview)
    }
    
    func fetchNextPage() async {
        do {
            guard let lastPost = posts.last, lastPostInDatabase != lastPost else {
                return
            }
            isShowingBottomProgress = true
            removeLeadingPostsIfNecessary()
            try? await Task.sleep(seconds: 3.0)
            let newPosts = try await postsPage(option: .after(id: lastPost.id))
            posts.append(contentsOf: newPosts)
            updateLastPostInDatabase(from: newPosts)
        } catch {
            print("Fetch next page error: \(error.localizedDescription)")
        }
        if !Task.isCancelled {
            isShowingBottomProgress = false
        }
    }
    
    func fetchPreviousPage() async {
        do {
            guard let firstPost = posts.first, firstPostInDatabase != firstPost else {
                return
            }
            isShowingTopProgress = true
            removeTrailingPostsIfNecessary()
            try? await Task.sleep(seconds: 3.0)
            let newPosts = try await postsPage(option: .before(id: firstPost.id))
            posts = newPosts + posts
        } catch {
            print("Fetch previous page error: \(error.localizedDescription)")
        }
        if !Task.isCancelled {
            isShowingTopProgress = false
        }
    }
}

// MARK: - Private Methods
private extension CommunityHomeFeedViewModel {
    
    func refreshPosts() async {
        do {
            posts = try await postsPage(option: .initial)
            firstPostInDatabase = posts.first
            if posts.count < Self.pageCount {
                lastPostInDatabase = posts.last
            }
        } catch {
            print("Refresh posts error: \(error.localizedDescription)")
        }
        if !Task.isCancelled {
            isShowingTopProgress = false
        }
    }
    
    // As the user is scrolling down, if there are too many posts in memory,
    // remove them from the front of the `posts` array.
    func removeLeadingPostsIfNecessary() {
        if posts.count >= Self.maxInMemoryPostCount {
            posts.removeFirst(Self.pageCount)
        }
    }
    
    // As the user is scrolling up, if there are too many posts in memory,
    // remove them from the end of the `posts` array.
    func removeTrailingPostsIfNecessary() {
        if posts.count >= Self.maxInMemoryPostCount {
            posts.removeLast(Self.pageCount)
        }
    }
    
    // If we find the last post in the database, assign it to `lastPostInDatabase`
    // so that we can use it to prevent unnecessary fetches.
    func updateLastPostInDatabase(from page: [Post]) {
        if page.count < Self.pageCount {
            if page.isEmpty {
                lastPostInDatabase = posts.last
            } else {
                lastPostInDatabase = page.last
            }
        }
    }
    
    func postsPage(option: CursorPaginationOption) async throws -> [Post] {
        try await postService.fetchPostsForCommunity(
            communityId: community.id,
            oldestDate: oldestFeedDate,
            option: option
        )
    }
}
