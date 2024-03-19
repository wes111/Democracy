//
//  CategoryModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/26/24.
//

import SwiftUI

struct SelectableModifier: ViewModifier {
    let colorScheme: ColorScheme
    
    func body(content: Content) -> some View {
        content
            .padding(ViewConstants.innerBorder)
            .background(
                colorScheme.onBackground,
                in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius)
            )
            .foregroundStyle(colorScheme.secondaryText)
    }
}

// MARK: View Extension
extension View {
    func selectableModifier(colorScheme: ColorScheme = .init()) -> some View {
        modifier(SelectableModifier(colorScheme: colorScheme))
    }
}

// MARK: Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        Text("Category")
            .selectableModifier()
    }
}
