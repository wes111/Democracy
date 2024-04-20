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
    @Bindable var viewModel: CommunityHomeFeedViewModel
    
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
    
    func postShouldShowBottomProgress(_ post: Post) -> Bool {
        viewModel.isShowingBottomProgress && (post == viewModel.posts.last)
    }
    
    func postShouldShowTopProgress(_ post: Post) -> Bool {
        viewModel.isShowingTopProgress && (post == viewModel.posts.first)
    }
    
    func scrollProgresssView(isVisible: Bool) -> some View {
        ProgressView()
            .controlSize(.large)
            .opacity(isVisible ? 1.0 : 0.0)
            .frame(height: isVisible ? 20 : 0.0)
            .animation(.easeInOut, value: viewModel.isShowingTopProgress)
            .padding(isVisible ? 10 : 0)
    }
    
    var primaryContent: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.posts, id: \.self) { post in
                    var bottomProgressVisible = postShouldShowBottomProgress(post)
                    var topProgressVisible = postShouldShowTopProgress(post)
                    VStack(alignment: .center, spacing: 0) {
                        scrollProgresssView(isVisible: topProgressVisible)
                        
                        PostCardView(viewModel: viewModel.getPostCardViewModel(post: post))
                            .padding(.vertical, 5)
                            .task {
                                await viewModel.onAppear(post)
                            }
                        
                        scrollProgresssView(isVisible: bottomProgressVisible)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $viewModel.scrollId, anchor: .top)
    }
}

// MARK: - Preview
#Preview {
    CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
}
