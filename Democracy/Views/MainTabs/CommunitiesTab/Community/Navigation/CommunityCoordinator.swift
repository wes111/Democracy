//
//  CommunityCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/5/23.
//

import Foundation

protocol CommunityCoordinatorParent {
    func goToCommunity(communityId: String)
}

class CommunityCoordinator: Coordinator, CommunityCoordinatorDelegate {
    
    @Published var url: URL = URL(string: "https://www.google.com")!
    @Published var isShowingWebView = false
    @Published var isShowingCreatePostView = false
    @Published var isShowingCreateCandidateView = false
    
    let community: Community
    let parentCoordinator: CommunityCoordinatorParent
    
    init(
        community: Community,
        router: Router,
        parentCoordinator: CommunityCoordinatorParent
    ) {
        self.community = community
        self.parentCoordinator = parentCoordinator
        
        super.init(router: router)
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
        // TODO: Get the actual post category.
        router.push(CommunityPath.goToCommunityPostCategory(category: .preview))
    }
    
    func goToPostView(_ post: Post) {
        router.push(CommunityPath.postView(post))
    }
    
    func goToCandidateView(candidateId: String) {
        // TODO: Get the actual candidate.
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
    
    func postViewModel(post: Post) -> PostViewModel {
        PostViewModel(post: post)
    }
    
    func communityPostCategoryViewModel(category: CommunityCategory) -> CommunityCategoryPostsViewModel {
        CommunityCategoryPostsViewModel(community: community, category: category)
    }
    
    func communityViewModel() -> CommunityViewModel {
        CommunityViewModel(coordinator: self, community: community)
    }
    
    func addPostViewModel() -> AddPostViewModel {
        AddPostViewModel(coordinator: self)
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
extension CommunityCoordinator: AddPostCoordinatorDelegate {
    
    func close() {
        isShowingCreatePostView = false
    }
}

extension CommunityCoordinator: CandidatesCoordinatorDelegate {
    
    func showCreateCandidateView() {
        isShowingCreateCandidateView = true
    }
    
    func closeCreateCandidateView() {
        isShowingCreateCandidateView = false
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
