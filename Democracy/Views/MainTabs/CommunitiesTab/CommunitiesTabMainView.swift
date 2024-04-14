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
    
    init(viewModel: CommunitiesTabMainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .toolbarNavigation(leadingContent: leadingButtons, trailingContent: trailingButtons)
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .onChange(of: viewModel.category) { _, category in
                viewModel.fetchCommunitiesByCategory(category)
            }
            .onAppear {
                viewModel.onAppear()
            }
            .refreshable {
                await viewModel.forceRefreshMemberships()
            }
    }
}

// MARK: - Subviews
private extension CommunitiesTabMainView {
    
    var menuOptions: [MenuButtonOption] {
        [.init(title: "Create Community", action: viewModel.showCreateCommunityView)]
    }
    
    var trailingButtons: [TopBarContent] {
        [.search({}), .menu(menuOptions)]
    }
    
    var leadingButtons: [TopBarContent] {
        [.title("Communities")]
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            HorizontalSelectableList(selection: $viewModel.category)
            communityList
        }
        .padding(.horizontal, ViewConstants.screenPadding)
    }
    
    var communityList: some View {
        PlainListView(items: viewModel.allCommunities) { community in
            TappableListItem(title: community.name, subtitle: community.tagline) {
                viewModel.goToCommunity(community)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunitiesTabMainView(viewModel: CommunitiesTabMainViewModel.preview)
    }
}
