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
            .limitCharacters(
                text: $username,
                count: OnboardingInputField.username.maxCharacterCount
            )
            .keyboardType(.default)
            .textContentType(.username)
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
        
        TextField("Username", text: .constant("Username"),
                  prompt: Text("Username").foregroundColor(.secondaryBackground)
        )
        .textFieldStyle(UsernameTextFieldStyle(username: .constant("Username")))
    }
}
