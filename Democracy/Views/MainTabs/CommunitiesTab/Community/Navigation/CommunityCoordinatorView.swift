//
//  CommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import SwiftUI

struct CommunityCoordinatorView: View {
    
    @State private var coordinator: CommunityCoordinator
    
    init(viewModel: CommunityCoordinator) {
        coordinator = viewModel
    }
    
    var body: some View {
        
        ChildCoordinatorView(router: coordinator.router) {
            CommunityViewPicker(viewModel: coordinator.communityViewModel())
        } secondaryScreen: { path in
            createViewFromPath(path)
        }
        
        // TODO: This should be a fullScreenCover not popover.
        // This temporarily fixes an iOS 17 memory leak.
        // https://developer.apple.com/forums/thread/736239
        //            .fullScreenCover(isPresented: $coordinator.isShowingCreatePostView) {
        //                SubmitPostCoordinatorView(coordinator: .init(parentCoordinator: coordinator))
        //            }
        .popover(isPresented: $coordinator.isShowingCreatePostView) {
            SubmitPostCoordinatorView(coordinator: .init(parentCoordinator: coordinator))
        }
        .sheet(isPresented: $coordinator.isShowingWebView) {
            WebView(url: $coordinator.url)
        }
        .fullScreenCover(isPresented: $coordinator.isShowingCreateCandidateView) {
            CreateCandidateView(viewModel: coordinator.createCandidateViewModel())
        }
    }
    
    @MainActor @ViewBuilder
    func createViewFromPath(_ path: CommunityPath) -> some View {
        switch path {
            
        case .postView(let post):
            PostView(viewModel: coordinator.postViewModel(post: post))
            
        case .candidates:
            CandidatesView(viewModel: coordinator.candidatesViewModel())
            
        case .singleCandidate(let candidate):
            CandidateView(viewModel: coordinator.candidateViewModel(candidate: candidate))
            
        case .goToCommunityPostCategory(let category):
            CommunityCategoryPostsView(
                viewModel: coordinator.communityPostCategoryViewModel(category: category)
            )
            
        case .voteView:
            VoteView(viewModel: coordinator.voteViewModel())
        }
    }
}

// MARK: - Preview
#Preview {
    CommunityCoordinatorView.preview
}
