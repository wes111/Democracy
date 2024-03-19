//
//  DescriptionField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/24.
//

import SwiftUI



struct DescriptionField<Field: Hashable>: View {
    @Binding var description: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    var body: some View {
        TextField(
            "Description",
            text: $description,
            prompt: Text("Description").foregroundColor(.tertiaryBackground),
            axis: .vertical
        )
        .lineLimit(3...4)
        .requirements(
            text: $description,
            requirementType: DefaultRequirement.self
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: $description,
            focusedField: $focusedField,
            field: field
        ))
        .titledElement(title: "Description")
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: AddResourceField?
    
    return DescriptionField(
        description: .constant("Description"),
        focusedField: $focusedField,
        field: AddResourceField.description
    )
}
