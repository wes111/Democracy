//
//  TextInputRequirementsModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/11/24.
//

import SwiftUI

// Adds requirements directly below a text input element (field or editor).
struct TextInputRequirementsModifier<Requirement: InputRequirement>: ViewModifier {
    @Binding var text: String
    @State private var textErrors: [Requirement] = []
    
    init(text: Binding<String>, requirementType: Requirement.Type) {
        self._text = text
    }
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
            content
            requirements
        }
        .onChange(of: text) { _, newValue in
            textErrors = if newValue.isEmpty {
                []
            } else {
                Requirement.getInputValidationErrors(input: newValue)
            }
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
        text: Binding<String>,
        requirementType: Requirement.Type
    ) -> some View {
        modifier(TextInputRequirementsModifier(
            text: text,
            requirementType: requirementType
        ))
    }
}

// MARK: - Preview
#Preview {
    TextField("TextField", text: .constant("Hello World"))
        .requirements(
            text: .constant("Hello World!"),
            requirementType: DefaultRequirement.self
        )
}
