//
//  CommunityPostCategoryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import SwiftUI

struct CommunityCategoryPostsView: View {
    
    @StateObject private var viewModel: CommunityCategoryPostsViewModel
    
    init(viewModel: CommunityCategoryPostsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.posts, id: \.self) { postCardViewModel in
                PostCardView(viewModel: postCardViewModel)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(viewModel.community.name)
                    Text(viewModel.category)
                }
            }
        }
        .searchable(text: $viewModel.searchText)
        .refreshable {
            viewModel.refresh()
        }
    }
}

// MARK: - Preview
#Preview {
    CommunityCategoryPostsView(viewModel: CommunityCategoryPostsViewModel.preview)
}
