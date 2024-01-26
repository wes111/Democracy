//
//  CategoryModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/26/24.
//

import SwiftUI

struct CategoryModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(ViewConstants.innerBorder)
            .background(Color.onBackground, in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
            .foregroundStyle(Color.secondaryText)
    }
}

// MARK: View Extension
extension View {
    func categoryModifier() -> some View {
        modifier(CategoryModifier())
    }
}

// MARK: Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        Text("Category")
            .categoryModifier()
    }
}
