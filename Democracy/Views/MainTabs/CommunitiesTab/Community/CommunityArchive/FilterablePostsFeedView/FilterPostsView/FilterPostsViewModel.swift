//
//  FilterPostsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import Foundation

@MainActor @Observable
final class FilterPostsViewModel {
    let communityTags: [CommunityTag]
    let onUpdateFilters: (PostFilters) -> Void
    var router = Router()
    var postFilters: PostFilters
    
    init(
        communityTags: [CommunityTag],
        postFilters: PostFilters,
        onUpdateFilters: @escaping (PostFilters) -> Void
    ) {
        self.postFilters = postFilters
        self.communityTags = communityTags
        self.onUpdateFilters = onUpdateFilters
    }
}

// MARK: - Computed Properties
extension FilterPostsViewModel {
    
    var categoriesSubtitle: String {
        if postFilters.tagsFilter.isEmpty {
            "None Selected"
        } else {
            postFilters.tagsFilter.sorted().joined(separator: ", ")
        }
    }
}

// MARK: - Methods
extension FilterPostsViewModel  {
    
    func navigateToPath(_ path: FilterPostsPath) {
        router.push(path)
    }
    
    func backAction() {
        router.pop()
    }
    
    func toggleTag(_ tag: String) {
        if postFilters.tagsFilter.contains(tag) {
            postFilters.tagsFilter.removeAll(where: { $0 == tag })
        } else {
            postFilters.tagsFilter.append(tag)
        }
    }
    
    func onTapUpdateFilters() {
        onUpdateFilters(postFilters)
    }
}
