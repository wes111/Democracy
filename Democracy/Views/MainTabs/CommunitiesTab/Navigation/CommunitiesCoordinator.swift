//
//  CommunitiesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/6/23.
//

import Foundation

enum CommunityCoordinatorSheet: Identifiable {
    case webview
    case createPost(Community)
    case createCandidate
    case createCommunity
    
    var id: String {
        switch self {
        case .webview: "web"
        case .createPost(let community): "post"
        case .createCandidate: "candidate"
        case .createCommunity: "community"
        }
    }
}

@MainActor
protocol CommunitiesCoordinatorDelegate: AnyObject {
    func goToCommunity(community: Community)
    func showCreateCommunityView()
    func showCreateCandidateView()
    func showCreatePostView(for community: Community)
    func goBack()
    func closeCreateCandidateView()
    func goToCandidateView(candidateId: String)
    func goToVoteView()
    func goToPostView(_ post: Post)
    func showCandidates()
    func openResourceURL(_ url: URL)
    func goToCommunityPostCategory(category: PostCategory?, community: Community)
}

@MainActor @Observable
final class CommunitiesCoordinator: CommunitiesCoordinatorDelegate {
    var router = Router()
    var url: URL = URL(string: "https://www.google.com")!
    var sheetView: CommunityCoordinatorSheet?
    
    @ObservationIgnored lazy var communitiesTabMainViewModel: CommunitiesTabMainViewModel = {
        CommunitiesTabMainViewModel(coordinator: self)
    }()
}

// MARK: - Coordinating functions
extension CommunitiesCoordinator {
    
    func showCreateCommunityView() {
        sheetView = .createCommunity
    }
    
    func goToCommunity(community: Community) {
        router.push(CommunitiesTabPath.goToCommunity(community))
    }
    
    func dismiss() {
        sheetView = nil
    }
    
    func showCandidates() {
        router.push(CommunitiesTabPath.candidates)
    }
    
    func openResourceURL(_ url: URL) {
        self.url = url
        sheetView = .webview
    }
    
    func goToCommunityPostCategory(category: PostCategory?, community: Community) {
        router.push(CommunitiesTabPath.goToCommunityPostCategory(
            category: category,
            community: community
        ))
    }
    
    func goToPostView(_ post: Post) {
        router.push(CommunitiesTabPath.postView(post))
    }
    
    func goToCandidateView(candidateId: String) {
        router.push(CommunitiesTabPath.singleCandidate(.preview))
    }
    
    func showCreatePostView(for community: Community) {
        sheetView = .createPost(community)
    }
    
    func goBack() {
        router.pop()
    }
    
    func showCreateCandidateView() {
        sheetView = .createCandidate
    }
    
    func closeCreateCandidateView() {
        sheetView = nil
    }
    
    func goToCommunityView(community: Community) {
        goToCommunity(community: community)
    }
    
    func goToVoteView() {
        router.push(CommunitiesTabPath.voteView)
    }
    
}

// MARK: - Child ViewModels
extension CommunitiesCoordinator {
    
    // TODO: Using these functions in views will cause multiple inits and bugs...
    func candidateViewModel(candidate: Candidate) -> CandidateViewModel {
        CandidateViewModel(coordinator: self, candidate: candidate)
    }
    
    func postViewModel(post: Post) -> PostViewModel {
        PostViewModel(coordinator: self, post: post)
    }
    
    func communityPostCategoryViewModel(
        category: PostCategory?,
        community: Community
    ) -> FilterablePostsFeedViewModel {
        let query: PostsQuery = if let category {
            .category(name: category.name)
        } else {
            .approved
        }
        return FilterablePostsFeedViewModel(
            community: community,
            query: query,
            coordinator: self
        )
    }
    
    func communityViewModel(community: Community) -> CommunityViewModel {
        CommunityViewModel(coordinator: self, community: community)
    }
    
    func candidatesViewModel() -> CandidatesViewModel {
        CandidatesViewModel(coordinator: self)
    }
    
    func createCandidateViewModel() -> CreateCandidateViewModel {
        CreateCandidateViewModel(coordinator: self)
    }
    
//    func voteViewModel() -> VoteViewModel {
//        VoteViewModel(coordinator: self)
//    }
}

// MARK: - Child Coordinators
extension CommunitiesCoordinator: SubmitCommunityCoordinatorParent {}

extension CommunitiesCoordinator: SubmitPostCoordinatorParent {
    func dismissSubmitPostView() {
        sheetView = nil
    }
}

extension CommunitiesCoordinator: PostCoordinatorDelegate {
    
}
