//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabMainView: View {
    
    @Bindable var viewModel: CommunitiesTabMainViewModel
    @State private var multiSelection = Set<String>()
    
    init(viewModel: CommunitiesTabMainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            CommunitiesScrollView(
                title: "My Communities",
                communities: viewModel.allCommunities,
                onTapAction: viewModel.goToCommunity
            )
            .padding(.bottom)
            
//            CommunitiesScrollView(
//                title: "Recommended Communities",
//                communities: viewModel.recommendedCommunities,
//                onTapAction: viewModel.goToCommunity
//            )
//            .padding(.bottom)
//            
//            CommunitiesScrollView(
//                title: "Top Communities",
//                communities: viewModel.topCommunities,
//                onTapAction: viewModel.goToCommunity
//            )
            
        }
        .toolbarNavigation(
            trailingButtons: [.search({}), .menu(menuOptions)],
            centerContent: .title("Communities")
        )
    }
}

private extension CommunitiesTabMainView {
    var menuOptions: [MenuButtonOption] {
        [.init(title: "CreateCommunity", action: viewModel.showCreateCommunityView)]
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
