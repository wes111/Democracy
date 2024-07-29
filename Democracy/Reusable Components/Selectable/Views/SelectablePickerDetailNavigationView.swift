//
//  SelectablePickerDetailNavigationView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/29/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct SelectablePickerDetailNavigationView<Category: Selectable>: View {
    @Binding var selectedCategory: Category
    let backAction: () -> Void
    
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
private extension SelectablePickerDetailNavigationView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
            selectableContent
            selectButton
        }
        .padding(ViewConstants.screenPadding)
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

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        SelectablePickerDetailNavigationView(
            selectedCategory: .constant(CommunityGovernment.democracy),
            backAction: {}
        )
    }
}
