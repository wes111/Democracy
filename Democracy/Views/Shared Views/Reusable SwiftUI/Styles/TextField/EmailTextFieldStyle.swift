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
            .limitCharacters(
                text: $email,
                count: OnboardingInputField.email.maxCharacterCount
            )
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .standardTextField()
            .contentShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Email", text: .constant("Password"),
                  prompt: Text("Email").foregroundColor(.secondaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(email: .constant("Email")))
    }
}
