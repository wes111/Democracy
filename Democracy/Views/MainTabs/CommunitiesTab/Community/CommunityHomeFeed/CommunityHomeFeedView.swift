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
            .refreshable {
                viewModel.refreshPosts()
            }
    }
}

// MARK: - Subviews
private extension CommunityHomeFeedView {
    
    var primaryContent: some View {
        PlainListView(items: viewModel.posts) { item in
            PostCardView(viewModel: item)
        }
    }
}

// MARK: - Preview
#Preview {
    CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
}
