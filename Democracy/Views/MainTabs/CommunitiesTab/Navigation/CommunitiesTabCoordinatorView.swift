//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

@MainActor
struct CommunitiesTabCoordinatorView: View {
    @State private var coordinator = CommunitiesCoordinator()
    
    // https://developer.apple.com/forums/thread/736239
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            CommunitiesTabMainView(viewModel: coordinator.communitiesTabMainViewModel)
        } secondaryScreen: { (path: CommunitiesTabPath) in
            createViewFromPath(path)
        }
        .fullScreenCover(isPresented: $coordinator.isShowingCreateCommunityView) {
            SubmitCommunityCoordinatorView(coordinator: .init(parentCoordinator: coordinator))
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .goToCommunity(let community): 
            CommunityView(viewModel: coordinator.communityViewModel(community: community))
            
        case .postView(let post):
            PostView(viewModel: coordinator.postViewModel(post: post))
            
        case .candidates:
            CandidatesView(viewModel: coordinator.candidatesViewModel())
            
        case .singleCandidate(let candidate):
            CandidateView(viewModel: coordinator.candidateViewModel(candidate: candidate))
            
        case .goToCommunityPostCategory(let category, let community):
            let viewModel = coordinator.communityPostCategoryViewModel(
                category: category,
                community: community
            )
            CommunityCategoryPostsView(viewModel: viewModel)
            
        case .voteView:
            VoteView(viewModel: coordinator.voteViewModel())
        }
    }
}

// MARK: - Preview
#Preview {
    CommunitiesTabCoordinatorView()
}
