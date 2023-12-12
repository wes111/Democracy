//
//  CommunityHomeFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

struct CommunityHomeFeedView: View {
    
    @StateObject var viewModel: CommunityHomeFeedViewModel
    private let postSpacing: CGFloat = 10
    
    init(viewModel: CommunityHomeFeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View { // TODO: ....
            VStack(spacing: postSpacing) {
                pinnedPosts(pinnedPosts: viewModel.pinnedPosts)
                
                ForEach(viewModel.initialDates, id: \.self) { date in
                    VStack(spacing: postSpacing) {
                        topPostsForDateSection(
                            date: date,
                            topPosts: viewModel.topPostsForDate(date)
                        )
                    }
                }
            }
        .refreshable {
            viewModel.refreshPosts()
        }
    }
    
    func topPostsForDateSection(date: Date, topPosts: [PostCardViewModel]) -> some View {
        VStack(spacing: postSpacing) {
            ForEach(topPosts, id: \.post) { postCardViewModel in
                PostCardView(viewModel: postCardViewModel)
            }
        }
    }
    
    func pinnedPosts(pinnedPosts: [PostCardViewModel]) -> some View {
        VStack(spacing: postSpacing) {
            ForEach(pinnedPosts, id: \.post) { postCardViewModel in
                PostCardView(viewModel: postCardViewModel)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
}
