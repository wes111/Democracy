//
//  UsernameTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct UsernameTextFieldStyle: TextFieldStyle {
    @Binding var username: String
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.default)
            .textContentType(.username)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .standardTextInputAppearance(
                text: $username,
                maxCharacterCount: OnboardingInputField.username.maxCharacterCount
            )

    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Username", text: .constant("Username"),
                  prompt: Text("Username").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(UsernameTextFieldStyle(username: .constant("Username")))
    }
}
