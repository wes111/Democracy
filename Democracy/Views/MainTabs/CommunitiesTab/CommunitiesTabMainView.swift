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
            .toolbarNavigation(leadingButtons: leadingButtons, trailingButtons: trailingButtons)
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
    }
}

// MARK: - Subviews
private extension CommunitiesTabMainView {
    
    var menuOptions: [MenuButtonOption] {
        [.init(title: "Create Community", action: viewModel.showCreateCommunityView)]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.search({}), .menu(menuOptions)]
    }
    
    var leadingButtons: [ToolBarLeadingContent] {
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
        List(viewModel.allCommunities) { community in
            TappableListItem(
                title: community.name,
                subtitle: "TODO: What should go here?") {
                    viewModel.goToCommunity(community)
                }
                .listRowInsets(.init(
                    top: 0,
                    leading: 0,
                    bottom: ViewConstants.smallElementSpacing,
                    trailing: 0
                ))
                .listRowBackground(Color.primaryBackground)
        }
        .listStyle(.plain)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunitiesTabMainView(viewModel: CommunitiesTabMainViewModel.preview)
    }
}
