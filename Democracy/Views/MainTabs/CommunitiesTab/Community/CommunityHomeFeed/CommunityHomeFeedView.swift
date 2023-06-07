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
    
    var body: some View {
        OffsetObservingScrollView(offset: $viewModel.scrollOffset) {
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
        }
        .background(
            Color.primaryBackground
        )
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

struct CommunityHomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
            CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
    }
}
