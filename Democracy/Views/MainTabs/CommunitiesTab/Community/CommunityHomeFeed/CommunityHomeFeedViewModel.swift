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
    private let community: Community
    private let communityPostsManager: CommunityPostsManager
    var postViewModels: [PostCardViewModel] = []
    var posts: [Post] = []
    var scrollId: Post?
    var isShowingProgress: Bool = false
    var postsArrayId = 0
    
    @ObservationIgnored weak var coordinator: CommunitiesCoordinatorDelegate?

    init(community: Community, coordinator: CommunitiesCoordinatorDelegate?) {
        self.community = community
        self.communityPostsManager = CommunityPostsManager(community: community)
        self.coordinator = coordinator
        
        streamPostsTask()
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
    
    func refreshPosts() async {
        do {
            isShowingProgress = true
            try await communityPostsManager.refresh()
        } catch {
            print(error.localizedDescription)
        }
        isShowingProgress = false
    }
    
    func fetchNextPage() async { // Maybe this needs to be a task on the vm? Then only one task can happen at a time?
        do {
            isShowingProgress = true
            let newScrollId = self.posts.last
            try? await Task.sleep(seconds: 2.0)
            try await communityPostsManager.fetchNextPage()
            self.scrollId = newScrollId
        } catch {
            print(error.localizedDescription)
        }
        isShowingProgress = false
    }
    
    func fetchPreviousPage() async {
        do {
            isShowingProgress = true
            let newScrollId = self.posts.first
            try? await Task.sleep(seconds: 2.0)
            try await communityPostsManager.fetchPreviousPage()
            self.scrollId = newScrollId
        } catch {
            print(error.localizedDescription)
        }
        isShowingProgress = false
    }
}

// MARK: - Private Methods
private extension CommunityHomeFeedViewModel {
    
    func streamPostsTask() {
        Task {
            for await posts in communityPostsManager.stream {
                self.posts = posts
                self.postViewModels = posts.map { $0.toViewModel(coordinator: coordinator) }
                self.postsArrayId += 1
            }
        }
        
        Task {
            await refreshPosts()
        }
    }
}

// Using Cursor pagination (for Appwrite)
actor CommunityPostsManager {
    @ObservationIgnored @Injected(\.postService) private var postService
    
    private static let maxInMemoryPostCount = 50
    private static let pageCount = 25
    private var posts: [Post] = []
    private let community: Community
    
    private let continuation: AsyncStream<[Post]>.Continuation
    let stream: AsyncStream<[Post]>
    
    // TODO: Should this be a community setting? To choose how old of posts are displayed? day, month, year, etc...
    private let oldestFeedDate = Date.now
    
    init(community: Community) {
        self.community = community
        
        let (stream, continuation) = AsyncStream.makeStream(of: [Post].self)
        self.stream = stream
        self.continuation = continuation
    }
    
    func refresh() async throws {
        let newPosts = try await newPosts(option: .initial)
        posts = newPosts
        continuation.yield(posts)
    }
    
    // TODO: Need to see what Appwrite returns once we have requested all posts. (Empty Array or the same posts?)
    func fetchNextPage() async throws {
        guard let lastPostInMemory = posts.last else {
            return // No more to fetch.
        }
        
        let newPosts = try await newPosts(option: .after(id: lastPostInMemory.id))
        //print("Next page count: \(newPosts.count)")
        
        if !newPosts.isEmpty {
            if posts.count >= Self.maxInMemoryPostCount {
                posts.removeFirst(Self.pageCount)
            }
            posts.append(contentsOf: newPosts)
        }
        continuation.yield(posts)
    }
    
    func fetchPreviousPage() async throws {
        guard let firstPostInMemory = posts.first else {
            return // No previous to fetch.
        }
        
        let newPosts = try await newPosts(option: .before(id: firstPostInMemory.id))
        
        if posts.count >= Self.maxInMemoryPostCount {
            posts.removeLast(Self.pageCount)
        }
        posts = newPosts + posts
        continuation.yield(posts)
    }
    
    func newPosts(option: CursorPaginationOption) async throws -> [Post] {
        try await postService.fetchPostsForCommunity(
            communityId: community.id,
            oldestDate: oldestFeedDate,
            option: option
        )
    }
}
