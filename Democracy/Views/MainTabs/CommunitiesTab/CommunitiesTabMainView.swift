//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabMainView: View {
    
    @StateObject var viewModel: CommunitiesTabMainViewModel
    @State private var multiSelection = Set<UUID>()
    @State private var bob = "" //TODO: ...
    
    init(viewModel: CommunitiesTabMainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            CommunitiesScrollView(
                title: "My Communities",
                communities: viewModel.myCommunities,
                onTapAction: viewModel.goToCommunity
            )
            .padding(.bottom)
            
            CommunitiesScrollView(
                title: "Recommended Communities",
                communities: viewModel.recommendedCommunities,
                onTapAction: viewModel.goToCommunity
            )
            .padding(.bottom)
            
            CommunitiesScrollView(
                title: "Top Communities",
                communities: viewModel.topCommunities,
                onTapAction: viewModel.goToCommunity
            )
            
        }
        .navigationTitle("Communities")
        .refreshable {
            viewModel.refreshMyCommunities()
        }
        .searchable(text: $bob)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.showCreateCommunityView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
}

struct CommunitiesTabMainView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            CommunitiesTabMainView(viewModel: CommunitiesTabMainViewModel.preview)
        }
    }
}
