//
//  UsernameTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct UsernameTextFieldStyle<Field: Hashable>: TextFieldStyle {
    @Binding var username: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.default)
            .textContentType(.username)
            .standardTextInputAppearance(
                text: $username,
                focusedField: $focusedField,
                field: field
            )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: CreateAccountFlow?
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Username", text: .constant("Username"),
                  prompt: Text("Username").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(UsernameTextFieldStyle(
            username: .constant("Username"),
            focusedField: $focusedField,
            field: CreateAccountFlow.username
        ))
    }
}
