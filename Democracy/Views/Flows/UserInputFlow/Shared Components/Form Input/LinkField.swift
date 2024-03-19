//
//  LinkField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/27/24.
//

import SwiftUI

struct LinkField<Field: Hashable>: View {
    @Binding var link: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    var body: some View {
        DefaultTextInputField(
            text: $link,
            textFieldStyle: LinkTextFieldStyle(
                link: $link,
                focusedField: $focusedField,
                field: field
            ),
            fieldTitle: "Link",
            requirementType: LinkRequirement.self
        )
        .titledElement(title: "Link")
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: AddResourceField?
    
    return LinkField(
        link: .constant("Link"),
        focusedField: $focusedField,
        field: AddResourceField.link
    )
}
