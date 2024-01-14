//
//  TextInputRequirementsModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/11/24.
//

import SwiftUI

// Adds requirements directly below a text input element (field or editor).
struct TextInputRequirementsModifier<Requirement: InputRequirement>: ViewModifier {
    let text: String
    let textErrors: [Requirement]
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            content
            requirements
        }
    }
    
    var requirements: some View {
        FieldRequirementsView<Requirement>(
            text: text,
            currentInputErrors: textErrors
        )
    }
}

// MARK: - View Extension
extension View {
    func requirements<Requirement: InputRequirement>(
        text: String,
        textErrors: [Requirement]
    ) -> some View {
        modifier(TextInputRequirementsModifier<Requirement>(
            text: text,
            textErrors: textErrors
        ))
    }
}

// MARK: - Preview
#Preview {
    TextField("TextField", text: .constant("Hello World"))
        .requirements(text: "Hello World", textErrors: [UsernameRequirement.length])
}
