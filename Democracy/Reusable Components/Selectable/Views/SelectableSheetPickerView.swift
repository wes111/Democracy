//
//  SelectableSummaryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI
import SharedResourcesClientAndServer

@MainActor
struct SelectableSheetPickerView<T: Selectable>: View {
    @Binding var selection: T
    @State private var isPresented: Bool = false
    
    var body: some View {
        primaryContent
            .sheet(isPresented: $isPresented) {
                SelectablePickerDetailView(selectedCategory: $selection)
                    .presentationDetents([
                        .fraction(0.5)
                    ])
                    .presentationDragIndicator(.visible)
                    .background(Color.black, ignoresSafeAreaEdges: .all)
            }
    }
    
    var primaryContent: some View {
        TappableListItem(title: T.metaTitle, subtitle: selection.title, image: T.metaImage) {
            isPresented = true
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        SelectableSheetPickerView(selection: .constant(CommunityCommenter.experts))
            .padding()
    }
}
