//
//  TitleField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/27/24.
//

import SwiftUI

struct TitleField<Field: Hashable>: View {
    @Binding var title: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    var body: some View {
        DefaultTextInputField(
            text: $title,
            textFieldStyle: TitleTextFieldStyle(
                title: $title,
                focusedField: $focusedField,
                field: field
            ),
            fieldTitle: "Title",
            requirementType: DefaultRequirement.self
        )
        .titledElement(title: "Title")
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: AddResourceField?
    
    return TitleField(
        title: .constant("Title"),
        focusedField: $focusedField,
        field: AddResourceField.description
    )
}
