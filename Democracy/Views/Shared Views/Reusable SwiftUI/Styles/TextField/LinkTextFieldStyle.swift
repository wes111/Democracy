//
//  LinkTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/24.
//

import SwiftUI

struct LinkTextFieldStyle: TextFieldStyle {
    @Binding var link: String
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.URL)
            .standardTextInputAppearance(
                text: $link,
                maxCharacterCount: SubmitPostField.link.maxCharacterCount,
                shouldTrimWhileTyping: true
            )
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Link", text: .constant("Link"),
                  prompt: Text("Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(LinkTextFieldStyle(link: .constant("Link")))
        .padding()
    }
}
