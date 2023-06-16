//
//  CommunityCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 6/5/23.
//

import Foundation

class CommunityCoordinatorViewModel: ObservableObject, CommunityCoordinatorDelegate {
    
    @Published var url: URL = URL(string: "https://www.google.com")!
    @Published var isShowingWebView = false
    @Published var isShowingCreatePostView = false
    @Published var isShowingCreateCandidateView = false
    
    var router: Router
    let community: Community
    
    // TODO: Determine if these view models should be lazy or funcs.
    lazy var communityViewModel: CommunityViewModel = {
        CommunityViewModel(coordinator: self, community: community)
    }()
    
    lazy var addPostViewModel: AddPostViewModel = {
        AddPostViewModel(coordinator: self)
    }()
    
    lazy var candidatesViewModel: CandidatesViewModel = {
        CandidatesViewModel(coordinator: self)
    }()
    
    lazy var createCandidateViewModel: CreateCandidateViewModel = {
       CreateCandidateViewModel(coordinator: self)
    }()
    
    init(community: Community, router: Router) {
        self.community = community
        self.router = router
    }
    
    func candidateViewModel(candidate: Candidate) -> CandidateViewModel {
        CandidateViewModel(coordinator: self, candidate: candidate)
    }
    
    func postViewModel(post: Post) -> PostViewModel {
        PostViewModel(coordinator: self, post: post)
    }
    
    func communityPostCategoryViewModel(category: CommunityCategory) -> CommunityPostCategoryViewModel {
        CommunityPostCategoryViewModel(community: community, category: category)
    }
    
    func showCandidates() {
        router.push(CommunityPath.candidates)
    }
    
    func goToCommunity(_ community: Community) {
        router.push(CommunityPath.goToCommunity(community))
    }
    
    func openResourceURL(_ url: URL) {
        self.url = url
        isShowingWebView = true
    }
    
    func goToCommunityPostCategory(_ category: CommunityCategory) {
        router.push(CommunityPath.goToCommunityPostCategory(category: category))
    }
    
    func goToPostView(_ post: Post) {
        router.push(CommunityPath.postView(post))
    }
    
    func goToCandidateView(_ candidate: Candidate) {
        router.push(CommunityPath.singleCandidate(candidate))
    }
    
    func showCreatePostView() {
        isShowingCreatePostView = true
    }
    
    func goBack() {
        router.pop()
    }
}

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
