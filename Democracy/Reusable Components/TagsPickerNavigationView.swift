//
//  TagsPickerNavigationView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import SwiftUI

@MainActor
struct TagsPickerNavigationView: View {
    @Bindable var viewModel: FilterPostsViewModel
    
    var body: some View {
        content
            .frame(maxHeight: .infinity, alignment: .topLeading)
            .background(Color.secondaryBackground, ignoresSafeAreaEdges: .all)
            .toolbarNavigation(
                leadingContent: leadingToolbarContent,
                centerContent: centerToolbarContent,
                backgroundColor: .secondaryBackground
            )
    }
}

// MARK: - Subviews
private extension TagsPickerNavigationView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            selectableContent
            selectButton
        }
        .padding(ViewConstants.screenPadding)
    }
    
    var selectButton: some View {
        Button {
            viewModel.backAction()
        } label: {
            Text("Select")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
    
    var leadingToolbarContent: [TopBarContent] {
        [.back(viewModel.backAction)]
    }
    
    var centerToolbarContent: [TopBarContent] {
        [.title("Select Tags", size: .small)]
    }
    
    var selectableContent: some View {
        CollectionView(
            selectedItems: viewModel.postFilters.tagsFilter,
            items: viewModel.communityTags.map { $0.name }) { tag in
            viewModel.toggleTag(tag)
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        TagsPickerNavigationView(viewModel: .preview)
    }
}
