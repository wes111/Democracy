//
//  SelectableSummaryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI

struct SelectablePickerView<T: Selectable>: View {
    
    let action: () -> Void
    let dismissAction: () -> Void
    @Binding var selection: T
    @State private var isPresented: Bool = false
    
    var body: some View {
        primaryContent
            .sheet(isPresented: $isPresented, onDismiss: dismissAction) {
                SelectablePickerDetailView(selectedCategory: $selection)
                    .presentationDetents([
                        .fraction(detentsFraction(selectableType: T.self))
                    ])
                    .presentationDragIndicator(.visible)
                    .background(Color.black, ignoresSafeAreaEdges: .all)
            }
    }
    
    var primaryContent: some View {
        VStack {
            Button {
                isPresented = true
                action()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(T.metaTitle)
                            .font(.system(.body, weight: .semibold))
                            .foregroundStyle(Color.secondaryText)
                        
                        Text(selection.title)
                            .font(.system(.subheadline, weight: .medium))
                            .foregroundStyle(Color.secondaryText.opacity(0.5))
                    }
                    
                    Spacer()
                    
                    Image(systemName: SystemImage.chevronRight.rawValue)
                        .font(.system(.title3, weight: .semibold))
                        .foregroundStyle(Color.secondaryText)
                }
            }
            
            Divider()
                .frame(height: 1)
                .overlay(Color.secondaryText.opacity(0.5))
        }
    }
}

// MARK: - Helper Methods
private extension SelectablePickerView {
    
    func detentsFraction(selectableType: T.Type) -> Double {
        switch T.allCases.count {
        case 2:
            0.5
        case 3:
            0.6
        case 4:
            0.7
        case 5:
            0.8
        default:
            0.4
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        SelectablePickerView(
            action: {},
            dismissAction: {},
            selection: .constant(CommunityCommenter.experts)
        )
        .padding()
    }
}
