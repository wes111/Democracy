//
//  TitleTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct TitleTextFieldStyle: TextFieldStyle {
    @Binding var title: String
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.default)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .standardTextInputAppearance(
                text: $title,
                maxCharacterCount: SubmitPostField.title.maxCharacterCount
            )

    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Title", text: .constant("Title"),
                  prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(title: .constant("Email")))
        .padding()
    }
}
