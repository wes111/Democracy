//
//  EmailTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/3/23.
//

import SwiftUI

struct EmailTextFieldStyle: TextFieldStyle {
    @Binding var email: String
    @FocusState.Binding var focusedField: EmailValidator.FieldCollection?
    var textErrors: [EmailValidator.Requirement]
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .standardTextInputAppearance(
                input: EmailValidator.self,
                text: $email,
                focusedField: $focusedField,
                requirements: .some(
                    allPossibleErrors: EmailValidator.Requirement.allCases,
                    textErrors: textErrors
                )
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
            textErrors: [.invalidEmail]
        ))
    }
}
