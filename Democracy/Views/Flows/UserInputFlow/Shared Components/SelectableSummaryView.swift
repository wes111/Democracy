//
//  SelectableSummaryView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/5/24.
//

import SwiftUI

struct SelectableSummaryView: View {
    
    let action: () -> Void
    let title: String
    let currentSelection: String
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                HStack(alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(title)
                            .font(.system(.body, weight: .semibold))
                            .foregroundStyle(Color.secondaryText)
                        
                        Text(currentSelection)
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

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        SelectableSummaryView(
            action: {},
            title: "Hello World",
            currentSelection: "World"
        )
        .padding()
    }
}
