//
//  CommunityHomeFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

struct CommunityHomeFeedView<ViewModel: CommunityHomeFeedViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        List {
            Group {
                
                pinnedPosts(pinnedPosts: viewModel.pinnedPosts)
                
                ForEach(viewModel.initialDates, id: \.self) { date in
                    topPostsForDateSection(
                        date: date,
                        topPosts: viewModel.topPostsForDate(date)
                    )
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.refreshPosts()
        }
    }
    
    func topPostsForDateSection(date: Date, topPosts: [PostCardViewModel]) -> some View {
        
        Section {
            VStack(spacing: 10) {
                ForEach(topPosts, id: \.post) { postCardViewModel in
                    PostCardView(viewModel: postCardViewModel)
                }
            }
            
        } header: {
            Text(date.getFormattedDate(format: "MMMM dd"))
                .font(.title)
                .padding(.horizontal)
        }
    }
    
    func pinnedPosts(pinnedPosts: [PostCardViewModel]) -> some View {
        Section {
            VStack(spacing: 10) {
                ForEach(pinnedPosts, id: \.post) { postCardViewModel in
                    PostCardView(viewModel: postCardViewModel)
                }
            }
        } header: {
            Text("Pinned")
                .font(.title)
                .padding(.horizontal)
        }
    }
}

struct CommunityHomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
    }
}
