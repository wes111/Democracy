//
//  CategoriesSelectableView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
struct TagsPickerNavigationView: View {
    @Bindable var viewModel: FilterPostsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            selectableContent
            selectButton
        }
        .padding(ViewConstants.screenPadding)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.secondaryBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(
            leadingContent: leadingToolbarContent,
            centerContent: centerToolbarContent,
            backgroundColor: .secondaryBackground
        )
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
            items: viewModel.communityTags) { tag in
            viewModel.toggleTag(tag)
        }
    }
}

struct SelectablePickerDetailNavigationView<Category: Selectable>: View {
    @Binding var selectedCategory: Category
    let backAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            selectableContent
            selectButton
        }
        .padding(ViewConstants.screenPadding)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.secondaryBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(
            leadingContent: leadingToolbarContent,
            centerContent: centerToolbarContent,
            backgroundColor: .secondaryBackground
        )
    }
    
    var leadingToolbarContent: [TopBarContent] {
        [.back(backAction)]
    }
    
    var centerToolbarContent: [TopBarContent] {
        [.title("Select a \(Category.metaTitle)", size: .small)]
    }
    
    var selectableContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                ForEach(Category.allCases, id: \.self) { category in
                    SelectableView(
                        isSelected: selectedCategory == category,
                        title: category.title,
                        subtitle: category.subtitle,
                        image: category.image,
                        colorScheme: .sheetColorScheme
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
        }
        .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
    }
    
    var selectButton: some View {
        Button {
            backAction()
        } label: {
            Text("Select")
        }
        .buttonStyle(SeconaryButtonStyle())
    }
}

struct SelectablePickerDetailView<Category: Selectable>: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategory: Category
    
    var body: some View {
        VStack(alignment: .center, spacing: ViewConstants.extraLargeElementSpacing) {
            header
            selectableContent
        }
        .frame(alignment: .topLeading)
        .padding(.top, ViewConstants.partialSheetTopPadding)
        .padding([.horizontal, .bottom], ViewConstants.screenPadding)
        .background(Color.secondaryBackground, ignoresSafeAreaEdges: .all)
    }
}

// MARK: - Subviews
private extension SelectablePickerDetailView {
    
    var header: some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            closeButton
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("Select a \(Category.metaTitle)")
                .font(.system(.title2, weight: .semibold))
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.primaryText)
        }
    }
    
    var selectableContent: some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            ForEach(Category.allCases, id: \.self) { category in
                SelectableView(
                    isSelected: selectedCategory == category,
                    title: category.title,
                    subtitle: category.subtitle,
                    image: category.image,
                    colorScheme: .sheetColorScheme
                )
                .onTapGesture {
                    selectedCategory = category
                }
            }
        }
    }
    
    var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: SystemImage.xMark.rawValue)
                .foregroundColor(.tertiaryText)
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        SelectablePickerDetailView(
            selectedCategory: .constant(CommunityGovernment.democracy)
        )
    }
}
