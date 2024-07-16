//
//  CommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

@MainActor
struct CommunityView: View {
    @State private var viewModel: CommunityViewModel
    
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
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                communityOverview
                    .padding(.bottom, 10)
                headerButtons
                communitySection
            }
        }
        .clipped()
    }
    
    var headerButtons: some View {
        VStack(spacing: ViewConstants.smallInnerBorder) {
            HorizontalSelectableList(selection: $viewModel.selectedTab)
                .padding(.horizontal, ViewConstants.screenPadding)
                .font(.callout)
            
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
            PostsFeedView(viewModel: viewModel.communityHomeFeedViewModel())
            
        case .info:
            CommunityInfoView(viewModel: viewModel.communityInfoViewModel())
            
        case .archive:
            CommunityArchiveFeedView(viewModel: viewModel.communityArchiveViewModel())
        }
    }
    
    var communityOverview: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.secondaryText)
                
                VStack(alignment: .leading, spacing: ViewConstants.extraSmallElementSpacing) {
                    Text(viewModel.community.name)
                        .foregroundStyle(Color.secondaryText)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(viewModel.foundedText)
                        .foregroundStyle(Color.secondaryText)
                        .font(.caption2)
                    
                    Text(viewModel.membersText)
                        .foregroundStyle(Color.secondaryText)
                        .font(.caption2)
                }
                
                Spacer()
                
                joinLeaveButton
            }
            
            Text(viewModel.community.tagline)
                .foregroundStyle(Color.secondaryText)
                .font(.footnote)
        }
        .padding(.horizontal, ViewConstants.screenPadding)
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityView(viewModel: CommunityViewModel.preview)
    }
}
