//
//  CategoriesSelectableView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct SelectablePickerDetailNavigationView<Category: Selectable>: View {
    @Binding var selectedCategory: Category
    let backAction: () -> Void
    let closeAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            selectableContent
            selectButton
        }
        .padding(ViewConstants.screenPadding)
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .background(Color.sheetBackground, ignoresSafeAreaEdges: .all)
        .toolbarNavigation(
            leadingContent: leadingToolbarContent,
            centerContent: centerToolbarContent,
            trailingContent: trailingToolbarContent,
            backgroundColor: .sheetBackground
        )
    }
    
    var leadingToolbarContent: [TopBarContent] {
        [.back(backAction)]
    }
    
    var trailingToolbarContent: [TopBarContent] {
        [.close(closeAction)]
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
                        colorScheme: .onRed
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
        .background(Color.sheetBackground, ignoresSafeAreaEdges: .all)
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
                    colorScheme: .onRed
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
