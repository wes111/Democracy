//
//  CommunitiesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/6/23.
//

import Foundation

@MainActor
protocol CommunitiesCoordinatorDelegate: AnyObject {
    func goToCommunity(community: Community)
    func showCreateCommunityView()
    func showCreateCandidateView()
    func showCreatePostView()
    func goBack()
    func closeCreateCandidateView()
    func goToCandidateView(candidateId: String)
    func goToVoteView()
    func goToPostView(_ post: Post)
    func showCandidates()
    func openResourceURL(_ url: URL)
    func goToCommunityPostCategory(categoryId: String, community: Community)
}

@MainActor @Observable
final class CommunitiesCoordinator: CommunitiesCoordinatorDelegate {
    var isShowingCreateCommunityView = false
    var router = Router()
    var url: URL = URL(string: "https://www.google.com")!
    var isShowingWebView = false
    var isShowingCreatePostView = false
    var isShowingCreateCandidateView = false
    
    @ObservationIgnored lazy var communitiesTabMainViewModel: CommunitiesTabMainViewModel = {
        CommunitiesTabMainViewModel(coordinator: self)
    }()
}

// MARK: - Coordinating functions
extension CommunitiesCoordinator {
    
    func showCreateCommunityView() {
        isShowingCreateCommunityView = true
    }
    
    func goToCommunity(community: Community) {
        router.push(CommunitiesTabPath.goToCommunity(community))
    }
    
    func dismiss() {
        isShowingCreateCommunityView = false
    }
    
    func showCandidates() {
        router.push(CommunitiesTabPath.candidates)
    }
    
    func openResourceURL(_ url: URL) {
        self.url = url
        isShowingWebView = true
    }
    
    func goToCommunityPostCategory(categoryId: String, community: Community) {
        router.push(CommunitiesTabPath.goToCommunityPostCategory(
            category: Community.preview.categories.first!,
            community: community)
        )
    }
    
    func goToPostView(_ post: Post) {
        router.push(CommunitiesTabPath.postView(post))
    }
    
    func goToCandidateView(candidateId: String) {
        router.push(CommunitiesTabPath.singleCandidate(.preview))
    }
    
    func showCreatePostView() {
        isShowingCreatePostView = true
    }
    
    func goBack() {
        router.pop()
    }
    
    func showCreateCandidateView() {
        isShowingCreateCandidateView = true
    }
    
    func closeCreateCandidateView() {
        isShowingCreateCandidateView = false
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
    
    func postViewModel(post: Post) -> GARBAGEPostViewModel {
        GARBAGEPostViewModel(post: post)
    }
    
    func communityPostCategoryViewModel(category: String, community: Community) -> CommunityCategoryPostsViewModel {
        CommunityCategoryPostsViewModel(community: community, category: category)
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
    
    func voteViewModel() -> VoteViewModel {
        VoteViewModel(coordinator: self)
    }
}

// MARK: - Child Coordinators
extension CommunitiesCoordinator: SubmitCommunityCoordinatorParent {}
extension CommunitiesCoordinator: SubmitPostCoordinatorParent {}
