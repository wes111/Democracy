//
//  CommunityCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/5/23.
//

import Foundation

protocol CommunityCoordinatorParent {
    func goToCommunity(communityId: UUID)
}

class CommunityCoordinatorViewModel: Coordinator, CommunityCoordinatorDelegate {
    
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
extension CommunityCoordinatorViewModel {
    
    func showCandidates() {
        router.push(CommunityPath.candidates)
    }
    
    func openResourceURL(_ url: URL) {
        self.url = url
        isShowingWebView = true
    }
    
    func goToCommunityPostCategory(categoryId: UUID) {
        // TODO: Get the actual post category.
        router.push(CommunityPath.goToCommunityPostCategory(category: .preview))
    }
    
    func goToPostView(_ post: Post) {
        router.push(CommunityPath.postView(post))
    }
    
    func goToCandidateView(candidateId: UUID) {
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
extension CommunityCoordinatorViewModel {
    
    func candidateViewModel(candidate: Candidate) -> CandidateViewModel {
        CandidateViewModel(coordinator: self, candidate: candidate)
    }
    
    func postViewModel(post: Post) -> PostViewModel {
        PostViewModel(coordinator: self, post: post)
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
}

// MARK: - Protocols
extension CommunityCoordinatorViewModel: AddPostCoordinatorDelegate {
    
    func close() {
        isShowingCreatePostView = false
    }
}

extension CommunityCoordinatorViewModel: CandidatesCoordinatorDelegate {
    
    func showCreateCandidateView() {
        isShowingCreateCandidateView = true
    }
    
    func closeCreateCandidateView() {
        isShowingCreateCandidateView = false
    }
}

extension CommunityCoordinatorViewModel: CandidateCoordinatorDelegate {}

extension CommunityCoordinatorViewModel: CreateCandidateCoordinatorDelegate {}

extension CommunityCoordinatorViewModel: PostCoordinatorDelegate {}

extension CommunityCoordinatorViewModel: AlliedCommunitiesSectionViewModelCoordinatorDelegate {
    
    func goToCommunityView(id: UUID) {
        parentCoordinator.goToCommunity(communityId: id)
    }
}
