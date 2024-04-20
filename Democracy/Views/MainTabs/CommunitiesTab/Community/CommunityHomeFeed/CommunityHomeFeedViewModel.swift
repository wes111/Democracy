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
    var isShowingProgress: Bool = true
    
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
    
    func getPostCardViewModel(post: Post) -> PostCardViewModel {
        PostCardViewModel(coordinator: coordinator, post: post)
    }
    
    func goToPost() {
        coordinator?.goToPostView(Post.preview)
    }
    
    func fetchNextPage() async { // Maybe this needs to be a task on the vm? Then only one task can happen at a time?
        do {
            guard let lastPost = posts.last, lastPostInDatabase != lastPost else {
                return
            }
            isShowingProgress = true
            removeLeadingPostsIfNecessary()
            try? await Task.sleep(seconds: 2.0)
            let newPosts = try await postsPage(option: .after(id: lastPost.id))
            posts.append(contentsOf: newPosts)
            updateLastPostInDatabase(from: newPosts)
        } catch {
            print("Fetch next page error")
            //print(error.localizedDescription)
        }
        isShowingProgress = false
    }
    
    func fetchPreviousPage() async {
        do {
            guard let firstPost = posts.first, firstPostInDatabase != firstPost else {
                return
            }
            isShowingProgress = true
            removeTrailingPostsIfNecessary()
            try? await Task.sleep(seconds: 2.0)
            let newPosts = try await postsPage(option: .before(id: firstPost.id))
            posts = newPosts + posts
        } catch {
            print("Fetch previous page error")
            //print(error.localizedDescription)
        }
        isShowingProgress = false
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
            print("Refresh Post error")
            //print(error.localizedDescription)
        }
        isShowingProgress = false
    }
    
    func removeLeadingPostsIfNecessary() {
        if posts.count >= Self.maxInMemoryPostCount {
            posts.removeFirst(Self.pageCount)
            scrollId = self.posts.last
        }
    }
    
    func removeTrailingPostsIfNecessary() {
        if posts.count >= Self.maxInMemoryPostCount {
            posts.removeLast(Self.pageCount)
            scrollId = self.posts.first
        }
    }
    
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
