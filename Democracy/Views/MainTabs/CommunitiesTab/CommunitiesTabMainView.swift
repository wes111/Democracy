//
//  CommunitiesTabMainView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

@MainActor
struct CommunitiesTabMainView: View {
    
    @Bindable var viewModel: CommunitiesTabMainViewModel
    @State private var multiSelection = Set<String>()
    
    init(viewModel: CommunitiesTabMainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .toolbarNavigation(trailingButtons: trailingButtons, centerContent: .title("Communities"))
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
    }
}

// MARK: - Subviews
private extension CommunitiesTabMainView {
    
    var menuOptions: [MenuButtonOption] {
        [.init(title: "CreateCommunity", action: viewModel.showCreateCommunityView)]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.search({}), .menu(menuOptions)]
    }
    
    var content: some View {
        ScrollView(.vertical) {
            CommunitiesScrollView(
                title: "My Communities",
                communities: viewModel.allCommunities,
                onTapAction: viewModel.goToCommunity
            )
            .padding(.bottom)
        }
        .clipped()
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
