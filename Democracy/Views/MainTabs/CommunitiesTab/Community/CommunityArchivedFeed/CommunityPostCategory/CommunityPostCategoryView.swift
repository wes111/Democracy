//
//  CommunityPostCategoryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import SwiftUI

struct CommunityPostCategoryView<ViewModel: CommunityPostCategoryViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    @State private var searchText = ""
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(viewModel.posts, id: \.post) { postCardViewModel in
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
        .searchable(text: $searchText)
        .refreshable {
            viewModel.refresh()
        }
            
    }
    
}

struct CommunityPostCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityPostCategoryView(viewModel: CommunityPostCategoryViewModel.preview)
    }
}
