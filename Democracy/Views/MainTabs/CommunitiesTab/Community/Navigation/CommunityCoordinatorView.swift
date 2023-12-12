//
//  CommunityCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import Combine
import SwiftUI

struct CommunityCoordinatorView: View {
    
    @StateObject private var viewModel: CommunityCoordinator
    
    init(viewModel: CommunityCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        CommunityViewPicker(viewModel: viewModel.communityViewModel())
            .navigationDestination(for: CommunityPath.self) { path in
                ZStack {
                    Color.primaryBackground.ignoresSafeArea()
                    createViewFromPath(path)
                }
            }
            .fullScreenCover(isPresented: $viewModel.isShowingCreatePostView) {
                AddPostView(viewModel: viewModel.addPostViewModel())
            }
            .sheet(isPresented: $viewModel.isShowingWebView) {
                WebView(url: $viewModel.url)
            }
            .fullScreenCover(isPresented: $viewModel.isShowingCreateCandidateView) {
                CreateCandidateView(viewModel: viewModel.createCandidateViewModel())
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunityPath) -> some View {
        switch path {
            
        case .postView(let post):
            PostView(viewModel: viewModel.postViewModel(post: post))
            
        case .candidates:
            CandidatesView(viewModel: viewModel.candidatesViewModel())
            
        case .singleCandidate(let candidate):
            CandidateView(viewModel: viewModel.candidateViewModel(candidate: candidate))
            
        case .goToCommunityPostCategory(let category):
            CommunityCategoryPostsView(
                viewModel: viewModel.communityPostCategoryViewModel(category: category)
            )
            
        case .voteView:
            VoteView(viewModel: viewModel.voteViewModel())
        }
    }
}

// MARK: - Preview
#Preview {
    CommunityCoordinatorView.preview
}
