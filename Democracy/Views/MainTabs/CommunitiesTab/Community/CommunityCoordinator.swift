//
//  CommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import SwiftUI

enum CommunityPath: Hashable {
    case one
    case postView(Post)
    case candidates
    case singleCandidate(Candidate)
    case goToCommunity(Community)
}

struct CommunityCoordinator: View {
    
    @State private var isShowingCreatePostView = false
    @State private var isShowingCreateCandidateView = false
    @State private var isShowingWebView = false
    @State private var url: URL = URL(string: "https://www.google.com")!
    
    let community: Community
    private let router: Router
    
    init(_ community: Community,
         _ router: Router
    ) {
        self.community = community
        self.router = router
    }
    
    var body: some View {
        createCommunityView(community)
            .navigationDestination(for: CommunityPath.self) { path in
                createViewFromPath(path)
            }
            .fullScreenCover(isPresented: $isShowingCreatePostView) {
                createAddPostView()
            }
            .sheet(isPresented: $isShowingWebView) {
                WebView(url: $url)
            }
            .fullScreenCover(isPresented: $isShowingCreateCandidateView) {
                createCreateCandidateView()
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunityPath) -> some View {
        switch path {
        case .one: Text("")
        case .postView(let post): createPostView(post: post)
        case .candidates: createCandidatesView()
        case .singleCandidate(let candidate): createCandidateView(candidate)
        case .goToCommunity(let community): createCommunityView(community)
        }
    }
    
    func createCommunityView(_ community: Community) -> CommunityViewPicker<CommunityViewModel> {
        let viewModel = CommunityViewModel(coordinator: self, community: community)
        return CommunityViewPicker(viewModel: viewModel)
    }
    
    func createPostView(post: Post) -> PostView<PostViewModel> {
        let coordinator = PostCoordinator(post)
        let viewModel = PostViewModel(coordinator: coordinator, post: post)
        return PostView(viewModel: viewModel)
    }
    
    func createAddPostView() -> AddPostView<AddPostViewModel> {
        let viewModel = AddPostViewModel(coordinator: self)
        return AddPostView(viewModel: viewModel)
    }
    
    func createCandidatesView() -> CandidatesView<CandidatesViewModel> {
        let viewModel = CandidatesViewModel(coordinator: self)
        return CandidatesView(viewModel: viewModel)
    }
    
    func createCandidateView(_ candidate: Candidate) -> CandidateView<CandidateViewModel> {
        let viewModel = CandidateViewModel(coordinator: self, candidate: candidate)
        return CandidateView(viewModel: viewModel)
    }
    
    func createCreateCandidateView() -> CreateCandidateView<CreateCandidateViewModel> {
        let viewModel = CreateCandidateViewModel(coordinator: self)
        return CreateCandidateView(viewModel: viewModel)
    }
}

extension CommunityCoordinator: CommunityCoordinatorDelegate {
    
    func showCreatePostView() {
        isShowingCreatePostView = true
    }
    
}

extension CommunityCoordinator: CommunityHomeFeedCoordinatorDelegate {
    
    func goToPostView(_ post: Post) {
        router.push(CommunityPath.postView(post))
    }
}

extension CommunityCoordinator: AddPostCoordinatorDelegate {
    
    func close() {
        isShowingCreatePostView = false
    }
}

extension CommunityCoordinator: CommunityInfoCoordinatorDelegate {

    func goToCommunity(_ community: Community) {
        router.push(CommunityPath.goToCommunity(community))
    }
    
    func showCandidates() {
        router.push(CommunityPath.candidates)
    }
    
    func openResourceURL(_ url: URL) {
        self.url = url
        isShowingWebView = true
    }
    
}

extension CommunityCoordinator: CandidateCardCoordinatorDelegate {
    
    func goToCandidateView(_ candidate: Candidate) {
        router.push(CommunityPath.singleCandidate(candidate))
    }
}

extension CommunityCoordinator: CandidateCoordinatorDelegate {
    
}

extension CommunityCoordinator: CandidatesCoordinatorDelegate {
    
    func showCreateCandidateView() {
        isShowingCreateCandidateView = true
    }
    
    func closeCreateCandidateView() {
        isShowingCreateCandidateView = false
    }
    
}

extension CommunityCoordinator: CreateCandidateCoordinatorDelegate  {
    
}

extension CommunityCoordinator: CommunityArchiveFeedCoordinatorDelegate {
    
}

struct CommunityCoordinator_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            CommunityCoordinator.preview
        }
    }
}
