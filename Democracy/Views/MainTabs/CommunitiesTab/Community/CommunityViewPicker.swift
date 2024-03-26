//
//  CommunityView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/23.
//

import SwiftUI

@MainActor
struct CommunityViewPicker: View {
    @Bindable private var viewModel: CommunityViewModel
    
    init(viewModel: CommunityViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea(.all)
            content
        }
        .toolbarNavigation(
            leadingButtons: viewModel.leadingButtons,
            trailingButtons: viewModel.trailingButtons
        )
    }
}

// MARK: - Subviews
private extension CommunityViewPicker {
    var content: some View {
        VStack {
            HorizontalSelectableList(selection: $viewModel.selectedTab)
            
            switch viewModel.selectedTab {
            case .feed:
                CommunityHomeFeedView(viewModel: viewModel.getCommunityHomeFeedViewModel())
                
            case .info:
                CommunityInfoView(viewModel: viewModel.getCommunityInfoViewModel())
                
            case .archive:
                CommunityArchiveFeedView(viewModel: viewModel.getCommunityArchiveFeedViewModel())
            }
            
            Spacer()
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityViewPicker(viewModel: CommunityViewModel.preview)
            .accentColor(.secondaryText)
    }
}
