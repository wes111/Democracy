//
//  CategoriesSelectableView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI
import SharedResourcesClientAndServer

struct SelectablePickerDetailView<Category: Selectable>: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategory: Category
    
    var body: some View {
        VStack(alignment: .center, spacing: ViewConstants.elementSpacing) {
            Text("Select a \(Category.metaTitle)")
                .font(.system(.body, weight: .semibold))
                .foregroundStyle(Color.primaryText)
            
            selectableContent
            
            closeButton
        }
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .padding(.top, ViewConstants.partialSheetTopPadding)
        .padding([.horizontal, .bottom], ViewConstants.screenPadding)
        .background(Color.otherRed.opacity(0.4).ignoresSafeArea())
    }
}

// MARK: - Subviews
private extension SelectablePickerDetailView {
    
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
            Text("Close")
        }
        .buttonStyle(SeconaryButtonStyle())
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
