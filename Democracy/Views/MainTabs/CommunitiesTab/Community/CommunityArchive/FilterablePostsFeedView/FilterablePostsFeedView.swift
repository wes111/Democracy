//
//  FilterablePostsFeedView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/15/24.
//

import SwiftUI

@MainActor
struct FilterablePostsFeedView: View {
    @State private var viewModel: FilterablePostsFeedViewModel
    
    init(viewModel: FilterablePostsFeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .background(Color.primaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: leadingBarContent,
                centerContent: centerToolbarContent,
                trailingContent: trailingToolbarContent
            )
            .dynamicHeightSheet(isShowingSheet: $viewModel.isShowingFilters) {
                FilterPostsView(viewModel: viewModel.filterPostsViewModel)
                    .presentationDragIndicator(.visible)
                    .background(Color.secondaryBackground, ignoresSafeAreaEdges: .all)
                    .interactiveDismissDisabled()
            }
    }
}

// MARK: - Subviews
private extension FilterablePostsFeedView {
    
    var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                PostsFeedView(viewModel: viewModel)
            }
        }
        .clipped()
    }
    
    var leadingBarContent: [TopBarContent] {
        [.back(viewModel.goBack)]
    }
    
    var centerToolbarContent: [TopBarContent] {
        [.title(viewModel.categoryName, size: .small)]
    }
    
    var trailingToolbarContent: [TopBarContent] {
        [.filter({ viewModel.isShowingFilters = true })] // TODO: filter logic
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        FilterablePostsFeedView(viewModel: .previewFilterable)
    }
}
