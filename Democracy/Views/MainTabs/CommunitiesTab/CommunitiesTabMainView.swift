//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabMainView<ViewModel: CommunitiesTabMainViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var multiSelection = Set<UUID>()
    @State private var bob = "" //TODO: ...
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            CommunityScrollView(
                title: "My Communities",
                communities: viewModel.communities,
                onTapAction: viewModel.goToCommunity
            )
            .padding(.bottom)
            
            CommunityScrollView(
                title: "Recommended Communities",
                communities: viewModel.communities,
                onTapAction: viewModel.goToCommunity
            )
            .padding(.bottom)
            
            CommunityScrollView(
                title: "Top Communities",
                communities: viewModel.communities,
                onTapAction: viewModel.goToCommunity
            )
            
        }
        .navigationTitle("Communities")
        .refreshable {
            viewModel.refreshCommunities()
        }
        .searchable(text: $bob)
        //.toolbar { EditButton() }
    }
}

struct CommunitiesTabMainView_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabMainView(viewModel: CommunitiesTabMainViewModel.preview)
    }
}

struct CommunityScrollView: View {
    
    let title: String
    var communities: [Community]
    let onTapAction: (Community) -> Void
    
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
