//
//  PostCategoryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import SwiftUI

@MainActor
struct PostCategoryView: View {
    @Bindable var viewModel: PostCategoryViewModel
    
    init(viewModel: PostCategoryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        categoryList
            .onAppear {
                viewModel.onAppear()
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
    }
}

// MARK: - Subviews
private extension PostCategoryView {
    
    var primaryContent: some View {
        VStack {
            categoryList
            Spacer()
            SubmittableNextButton(viewModel: viewModel)
        }
    }
    
    var categoryList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                ForEach(viewModel.categories, id: \.self) { category in
                    categoryView(category)
                }
            }
        }
    }
    
    func categoryView(_ category: String) -> some View {
        SelectableView(
            isSelected: viewModel.selectedCategory == category,
            title: category
        )
        .onTapGesture {
            viewModel.toggleCategory(category)
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostCategoryView(viewModel: .preview)
    }
}
