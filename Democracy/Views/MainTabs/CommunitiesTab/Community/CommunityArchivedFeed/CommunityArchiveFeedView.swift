//
//  CommunityArchiveFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/7/23.
//

import SwiftUI

struct CommunityArchiveFeedView: View {
    
    @StateObject private var viewModel: CommunityArchiveFeedViewModel
    
    init(viewModel: CommunityArchiveFeedViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    private var gridItemLayout: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            LazyVGrid(columns: gridItemLayout, alignment: .center) {
                ForEach(viewModel.categories) { category in
                    CommunityCategoryView(viewModel: category)
                        .onTapGesture {
                            viewModel.goToCommunityPostCategory(category: category)
                        }
                        .padding(.vertical, 5)
                }
            }
            .padding([.bottom, .horizontal], 20)
        }
    }
}

struct CommunityArchiveFeedView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityArchiveFeedView(viewModel: CommunityArchiveFeedViewModel.preview)
    }
}
