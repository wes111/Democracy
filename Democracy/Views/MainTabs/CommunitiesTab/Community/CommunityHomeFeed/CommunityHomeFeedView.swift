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
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
    }
}

// MARK: - Subviews
private extension CommunityHomeFeedView {
    
    var primaryContent: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.posts, id: \.self) { post in
                    PostCardView(viewModel: viewModel.getPostCardViewModel(post: post))
                        .border(Color.yellow, width: 2)
                        .padding(.vertical, 5)
                        .task {
                            await viewModel.onAppear(post)
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
