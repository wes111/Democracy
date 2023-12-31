//
//  PostCategoryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import SwiftUI

struct PostCategoryView: View {
    @ObservedObject var viewModel: PostCategoryViewModel
    
    init(viewModel: PostCategoryViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        UserSelectionView(viewModel: viewModel) {
            categoryList
        }
    }
}

// MARK: - Subviews
private extension PostCategoryView {
    
    var categoryList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                ForEach(viewModel.categories) { category in
                    categoryView(category)
                }
            }
        }
    }
    
    func categoryView(_ category: CommunityCategory) -> some View {
        let isSelected = viewModel.selectedCategory == category
        
        return HStack {
            Text(category.name)
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .opacity(isSelected ? 1.0 : 0.0)
        }
        .padding(ViewConstants.innerBorder)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(isSelected ? Color.tertiaryText : Color.primaryBackground, lineWidth: 3)
                .fill(Color.white.opacity(0.1))
        )
        .foregroundStyle(Color.secondaryText)
        .onTapGesture {
            viewModel.toggleCategory(category)
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostCategoryViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return NavigationStack {
        PostCategoryView(viewModel: viewModel)
    }
}
