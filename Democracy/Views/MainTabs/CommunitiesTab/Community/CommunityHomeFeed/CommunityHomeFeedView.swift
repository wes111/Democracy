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
    @State private var viewScrollId: Post?
    
    init(viewModel: CommunityHomeFeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        primaryContent
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
            .refreshable {
                await viewModel.refreshPosts()
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .onChange(of: viewModel.scrollId) { _, newValue in
                withAnimation {
                    viewScrollId = newValue
                }
            }
    }
}

// MARK: - Subviews
private extension CommunityHomeFeedView {
    
    var primaryContent: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.posts, id: \.self) { post in
                    PostCardView(viewModel: post.toViewModel(coordinator: viewModel.coordinator))
                        .border(Color.yellow, width: 2)
                        .task {
                            if post == viewModel.posts.last {
                                await viewModel.fetchNextPage()
                            } else if post == viewModel.posts.first {
                                await viewModel.fetchPreviousPage()
                            }
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollPosition(id: $viewScrollId, anchor: .top)
        .id(viewModel.postsArrayId) // Redraw scrollView b/c we're changing both ends of the posts array.
    }
}

// MARK: - Preview
#Preview {
    CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
}
