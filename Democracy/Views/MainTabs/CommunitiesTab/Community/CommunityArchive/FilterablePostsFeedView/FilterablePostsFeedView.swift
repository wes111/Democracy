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
//            .sheet(isPresented: $viewModel.isShowingFilters, onDismiss: dismissAction) {
//                SelectablePickerDetailView(selectedCategory: $selection)
//                    .presentationDetents([
//                        .fraction(detentsFraction(selectableType: T.self))
//                    ])
//                    .presentationDragIndicator(.visible)
//                    .background(Color.black, ignoresSafeAreaEdges: .all)
//            }
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
        [.filter({})] // TODO: filter logic
    }
}

// MARK: - Preview
#Preview {
    FilterablePostsFeedView(viewModel: .preview2)
}
