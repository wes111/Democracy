//
//  UsernameTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct UsernameTextFieldStyle: TextFieldStyle {
    @Binding var username: String
    @FocusState.Binding var focusedField: UsernameValidator.FieldCollection?
    var textErrors: [UsernameValidator.Requirement]
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.default)
            .textContentType(.username)
            .standardTextInputAppearance(
                input: UsernameValidator.self,
                text: $username,
                focusedField: $focusedField,
                requirements: .some(
                    allPossibleErrors: UsernameValidator.Requirement.allCases,
                    textErrors: textErrors
                ))
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: OnboardingInputField?
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Username", text: .constant("Username"),
                  prompt: Text("Username").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(UsernameTextFieldStyle(
            username: .constant("Username Text"),
            focusedField: $focusedField,
            textErrors: UsernameValidator.Requirement.allCases
        ))
    }
}
