//
//  CommunityHomeFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

// Shows post from last 24 sorted by upvotes? Or let the community decide the sort time (24 hours, week, etc).
@MainActor
struct CommunityHomeFeedView: View {
    @State private var viewModel: CommunityHomeFeedViewModel
    
    init(viewModel: CommunityHomeFeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        primaryContent
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
    }
}

// MARK: - Subviews
private extension CommunityHomeFeedView {
    
    var primaryContent: some View {
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(viewModel.posts, id: \.self) { post in
                loadablePost(post)
            }
        }
    }
    
    func loadablePost(_ post: Post) -> some View {
        VStack(alignment: .center, spacing: 0) {
            scrollProgresssView(isVisible: viewModel.postShouldShowTopProgress(post))
            
            PostCardView(viewModel: viewModel.getPostCardViewModel(post: post))
                .task {
                    await viewModel.onAppear(post)
                }
            
            Divider()
                .overlay(Color.black)
            
            scrollProgresssView(isVisible: viewModel.postShouldShowBottomProgress(post))
        }
    }
    
    func scrollProgresssView(isVisible: Bool) -> some View {
        ProgressView()
            .controlSize(.large)
            .opacity(isVisible ? 1.0 : 0.0)
            .frame(height: isVisible ? 20 : 0.0)
            .padding(isVisible ? ViewConstants.sectionSpacing : 0)
    }
}

// MARK: - Preview
#Preview {
    CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
}
