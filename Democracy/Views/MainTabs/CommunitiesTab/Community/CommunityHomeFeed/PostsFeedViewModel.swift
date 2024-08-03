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
class PostsFeedViewModel {
    var posts: [Post] = []
    var scrollId: Post?
    private var isShowingTopProgress: Bool = true
    private var isShowingBottomProgress: Bool = false
    @ObservationIgnored private var refreshPostsTask: Task<Void, Never>?
    
    @ObservationIgnored @Injected(\.postService) private var postService
    @ObservationIgnored private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    // We use these variables to determine if the last/first post in the database is in memory.
    // If it is, then we do not need to try to fetch any more posts from the database.
    @ObservationIgnored private var lastPostInDatabase: Post?
    @ObservationIgnored private var firstPostInDatabase: Post?
    
    private static let maxInMemoryPostCount = 50
    private static let pageCount = 25
    let community: Community
    var isShowingFilters: Bool = false
    var postFilters: PostFilters
    
    init(community: Community, postFilters: PostFilters, coordinator: CommunitiesCoordinatorDelegate?) {
        self.postFilters = postFilters
        self.community = community
        self.coordinator = coordinator
    }
    
    deinit {
        refreshPostsTask?.cancel()
    }
}

// MARK: - Computed Properties
extension PostsFeedViewModel {
    
    var filterPostsViewModel: FilterPostsViewModel {
        .init(
            communityTags: community.tags,
            postFilters: postFilters,
            onUpdateFilters: onUpdatePostFilters(_:)
        )
    }
    
    var categoryName: String {
        postFilters.categoriesFilter?.name ?? ""
    }
}

// MARK: - Methods
extension PostsFeedViewModel {
    
    func onUpdatePostFilters(_ postFilters: PostFilters) {
        if postFilters != self.postFilters {
            posts = []
            self.postFilters = postFilters
            isShowingFilters = false
            self.refreshPostsTask = Task { [weak self] in
                // TODO: - Should probably show spinner here
                try? await Task.sleep(seconds: 5.0)
                await self?.refreshPosts()
            }
        } else {
            isShowingFilters = false
        }
    }
    
    func refreshPosts() async {
        do {
            posts = try await postsPage(paginationOption: .initial)
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
    
    func onAppear(_ post: Post) async {
        if post == posts.last {
            await fetchNextPage()
        } else if post == posts.first {
            await fetchPreviousPage()
        }
    }
    
    func goBack() {
        coordinator?.goBack()
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
            let newPosts = try await postsPage(paginationOption: .after(id: lastPost.id))
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
            let newPosts = try await postsPage(paginationOption: .before(id: firstPost.id))
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
private extension PostsFeedViewModel {
    
    func reset() async {
        scrollId = nil
        lastPostInDatabase = nil
        firstPostInDatabase = nil
        await refreshPosts()
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
    
    func postsPage(paginationOption: CursorPaginationOption) async throws -> [Post] {
        try await postService.fetchPostsForCommunity(
            communityId: community.id,
            filters: postFilters,
            paginationOption: paginationOption
        )
    }
}
