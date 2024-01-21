//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabMainView: View {
    
    @StateObject var viewModel: CommunitiesTabMainViewModel
    @State private var multiSelection = Set<String>()
    @State private var bob = ""
    
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

struct CommunitiesScrollView: View {
    
    let title: String
    var communities: [Community]
    let onTapAction: @MainActor (Community) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title2)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(communities) { community in
                        CommunityCard(community: community)
                            .padding(.leading)
                            .onTapGesture {
                                onTapAction(community)
                            }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunitiesTabMainView(viewModel: CommunitiesTabMainViewModel.preview)
            .background(Color.primaryBackground)
    }
}
