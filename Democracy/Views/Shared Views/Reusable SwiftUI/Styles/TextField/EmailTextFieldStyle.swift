//
//  EmailTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/3/23.
//

import SwiftUI

struct EmailTextFieldStyle<Field: InputField>: TextFieldStyle {
    @Binding var email: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .standardTextInputAppearance(
                text: $email,
                focusedField: $focusedField,
                field: field
            )
        
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: OnboardingInputField?
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Email", text: .constant("Password"),
                  prompt: Text("Email").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(
            email: .constant("Email"),
            focusedField: $focusedField,
            field: OnboardingInputField.email
        ))
    }
}
