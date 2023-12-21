//
//  PasswordTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/3/23.
//

import SwiftUI

struct PasswordTextFieldStyle: TextFieldStyle {
    @Binding var password: String
    let isNewPassword: Bool
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.default)
            .textContentType(isNewPassword ? .newPassword : .password)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .foregroundStyle(Color.primaryText)
            .padding(.vertical)
            .limitCharacters(text: $password, count: OnboardingInputField.password.maxCharacterCount)
            .trimWhiteSpace(text: $password)
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Email", text: .constant("Password"),
                  prompt: Text("Email").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(PasswordTextFieldStyle(password: .constant("Password"), isNewPassword: false))
    }
}
