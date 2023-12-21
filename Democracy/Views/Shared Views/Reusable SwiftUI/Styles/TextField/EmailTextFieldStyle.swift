//
//  EmailTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/3/23.
//

import SwiftUI

struct EmailTextFieldStyle: TextFieldStyle {
    @Binding var email: String
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .standardTextInputAppearance(
                text: $email,
                maxCharacterCount: OnboardingInputField.email.maxCharacterCount
            )
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Email", text: .constant("Password"),
                  prompt: Text("Email").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(email: .constant("Email")))
    }
}
