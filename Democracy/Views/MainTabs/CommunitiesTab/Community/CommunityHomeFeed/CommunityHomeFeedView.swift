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
        ScrollView {
            LazyVStack {
                ForEach(viewModel.posts) { post in
                    createPostCardView(post)
                }
            }
        }
        .refreshable {
            //viewModel.refreshCommunities()
        }
    }
    
    func createPostCardView(_ post: Post) -> PostCardView<PostCardViewModel> {
        let viewModel = PostCardViewModel(coordinator: viewModel.coordinator, post: post)
        return PostCardView(viewModel: viewModel)
    }
}

struct CommunityHomeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityHomeFeedView(viewModel: CommunityHomeFeedViewModel.preview)
    }
}
