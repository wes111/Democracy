//
//  CommunityCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/5/23.
//

import Foundation

protocol CommunityCoordinatorParent {
    @MainActor func goToCommunity(communityId: String)
}

@MainActor @Observable
final class CommunityCoordinator: CommunityCoordinatorDelegate {
    
    var url: URL = URL(string: "https://www.google.com")!
    var isShowingWebView = false
    var isShowingCreatePostView = false
    var isShowingCreateCandidateView = false
    var router: Router
    
    let community: Community
    let parentCoordinator: CommunityCoordinatorParent
    
    init(
        community: Community,
        router: Router,
        parentCoordinator: CommunityCoordinatorParent
    ) {
        self.community = community
        self.parentCoordinator = parentCoordinator
        self.router = router
    }
    
}

// MARK: - Coordinating functions
extension CommunityCoordinator {
    
    func showCandidates() {
        router.push(CommunityPath.candidates)
    }
    
    func openResourceURL(_ url: URL) {
        self.url = url
        isShowingWebView = true
    }
    
    func goToCommunityPostCategory(categoryId: String) {
        router.push(CommunityPath.goToCommunityPostCategory(category: Community.preview.categories.first!))
    }
    
    func goToPostView(_ post: Post) {
        router.push(CommunityPath.postView(post))
    }
    
    func goToCandidateView(candidateId: String) {
        router.push(CommunityPath.singleCandidate(.preview))
    }
    
    func showCreatePostView() {
        isShowingCreatePostView = true
    }
    
    func goBack() {
        router.pop()
    }
    
}

// MARK: - Child ViewModels
extension CommunityCoordinator {
    
    func candidateViewModel(candidate: Candidate) -> CandidateViewModel {
        CandidateViewModel(coordinator: self, candidate: candidate)
    }
    
    func postViewModel(post: Post) -> GARBAGEPostViewModel {
        GARBAGEPostViewModel(post: post)
    }
    
    func communityPostCategoryViewModel(category: String) -> CommunityCategoryPostsViewModel {
        CommunityCategoryPostsViewModel(community: community, category: category)
    }
    
    func communityViewModel() -> CommunityViewModel {
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

// MARK: - Protocols

extension CommunityCoordinator: CandidatesCoordinatorDelegate {
    
    func showCreateCandidateView() {
        isShowingCreateCandidateView = true
    }
    
    func closeCreateCandidateView() {
        isShowingCreateCandidateView = false
    }
}

extension CommunityCoordinator: SubmitPostCoordinatorParent {
    func dismiss() {
        isShowingCreatePostView = false
    }
}

extension CommunityCoordinator: CandidateCoordinatorDelegate {}

extension CommunityCoordinator: CreateCandidateCoordinatorDelegate {}

extension CommunityCoordinator: PostCoordinatorDelegate {}

extension CommunityCoordinator: AlliedDelegate {
    
    func goToCommunityView(id: String) {
        parentCoordinator.goToCommunity(communityId: id)
    }
}

extension CommunityCoordinator: LeadersCoordinatorDelegate {
    
    func goToVoteView() {
        router.push(CommunityPath.voteView)
    }
}

extension CommunityCoordinator: VoteViewCoordinator {}
