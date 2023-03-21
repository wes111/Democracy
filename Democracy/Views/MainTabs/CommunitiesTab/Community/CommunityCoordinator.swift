//
//  CommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

enum CommunityPath: Hashable {
    case one
    case postView(Post)
    case candidates
    case singleCandidate(Candidate)
}

struct CommunityCoordinator: View {
    
    @State private var isShowingCreatePostView = false
    let community: Community
    private let router: Router
    
    
    init(_ community: Community,
         _ router: Router
    ) {
        self.community = community
        self.router = router
    }
    
    var body: some View {
        createCommunityView()
            .navigationDestination(for: CommunityPath.self) { path in
                createViewFromPath(path)
            }
            .fullScreenCover(isPresented: $isShowingCreatePostView) {
                createAddPostView()
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunityPath) -> some View {
        switch path {
        case .one: Text("")
        case .postView(let post): createPostView(post: post)
        case .candidates: createCandidatesView()
        case .singleCandidate(let candidate): createCandidateView(candidate)
        }
    }
    
    func createCommunityView() -> CommunityViewPicker<CommunityViewModel> {
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
}

extension CommunityCoordinator: CommunityCoordinatorDelegate {
    
    func showCreatePostView() {
        //TODO: Causes 'Update NavigationAuthority bound path tried to update multiple times per frame.'
        isShowingCreatePostView = true
    }

    func go() {
        print("go")
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
    
    func showCandidates() {
        router.push(CommunityPath.candidates)
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
    
}

struct CommunityCoordinator_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            CommunityCoordinator.preview
        }
    }
}
