//
//  CommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

@MainActor
struct CommunityView: View {
    @Bindable private var viewModel: CommunityViewModel
    
    init(viewModel: CommunityViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: viewModel.leadingContent,
                centerContent: viewModel.centerContent,
                trailingContent: viewModel.trailingContent
            )
    }
}

// MARK: - Subviews
private extension CommunityView {
    var content: some View {
        VStack {
            header
            communitySection
            Spacer()
        }
    }
    
    var header: some View {
        VStack(spacing: 0) {
            HStack {
                viewTitle
                Spacer()
                joinLeaveButton
            }
            HorizontalSelectableList(selection: $viewModel.selectedTab)
        }
    }
    
    var viewTitle: some View {
        Text(viewModel.community.name)
            .primaryTitle()
    }
    
    var joinLeaveButton: some View {
        AsyncButton(
            action: viewModel.toggleCommunityMembership,
            label: {
                Text(viewModel.membership == nil ? "Join" : "Leave")
            },
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(SmallSecondaryButtonStyle())
        .disabled(false)
    }
    
    @ViewBuilder
    var communitySection: some View {
        switch viewModel.selectedTab {
        case .feed:
            CommunityHomeFeedView(viewModel: viewModel.getCommunityHomeFeedViewModel())
            
        case .info:
            CommunityInfoView(viewModel: viewModel.getCommunityInfoViewModel())
            
        case .archive:
            CommunityArchiveFeedView(viewModel: viewModel.getCommunityArchiveFeedViewModel())
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityView(viewModel: CommunityViewModel.preview)
            .accentColor(.secondaryText)
    }
}
