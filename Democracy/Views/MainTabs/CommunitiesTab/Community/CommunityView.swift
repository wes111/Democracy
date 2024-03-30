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
                leadingButtons: viewModel.leadingButtons,
                trailingButtons: viewModel.trailingButtons
            )
    }
}

// MARK: - Subviews
private extension CommunityView {
    var content: some View {
        VStack() {
            header
            communitySection
            Spacer()
        }
    }
    
    var header: some View {
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.community.name)
                    .primaryTitle()
                
                Spacer()
                
                AsyncButton(action: viewModel.joinCommunity, label: {
                    Text("Join")
                }, showProgressView: $viewModel.isShowingProgress)
                .buttonStyle(SmallSecondaryButtonStyle())
                .disabled(false)
            }
            HorizontalSelectableList(selection: $viewModel.selectedTab)
        }
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
