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
        ZStack(alignment: .topLeading) {
            Color.clear
            
            VStack(alignment: .leading, spacing: 0) {
                headerButtons
                communitySection
            }
        }
    }
    
    var headerButtons: some View {
        VStack(spacing: ViewConstants.smallInnerBorder) {
            HStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
                HorizontalSelectableList(selection: $viewModel.selectedTab)
                joinLeaveButton
            }
            .padding(.horizontal, ViewConstants.screenPadding)
            
            Divider()
                .overlay(Color.black)
        }

    }
    
    var joinLeaveButton: some View {
        AsyncButton(
            action: viewModel.toggleCommunityMembership,
            label: {
                Text(viewModel.membershipButtonTitle)
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
            CommunityHomeFeedView(viewModel: viewModel.communityHomeFeedViewModel())
            
        case .info:
            CommunityInfoView(viewModel: viewModel.communityInfoViewModel())
            
        case .archive:
            CommunityArchiveFeedView(viewModel: viewModel.communityArchiveFeedViewModel())
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityView(viewModel: CommunityViewModel.preview)
    }
}
