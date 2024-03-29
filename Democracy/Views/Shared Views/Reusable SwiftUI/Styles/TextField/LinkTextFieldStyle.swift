//
//  LinkTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/24.
//

import SwiftUI

struct LinkTextFieldStyle<Field: Hashable>: TextFieldStyle {
    @Binding var link: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.URL)
            .standardTextInputAppearance(
                text: $link,
                focusedField: $focusedField,
                field: field
            )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: PostFlow.ID?
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Link", text: .constant("Link"),
                  prompt: Text("Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(LinkTextFieldStyle(
            link: .constant("Link"),
            focusedField: $focusedField,
            field: .primaryLink
        ))
        .padding()
    }
}
