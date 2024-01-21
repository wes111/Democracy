//
//  TitleTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct TitleTextFieldStyle<Field: InputField>: TextFieldStyle {
    @Binding var title: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.default)
            .standardTextInputAppearance(
                text: $title,
                focusedField: $focusedField,
                field: field,
                shouldTrimWhileTyping: false
            )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: SubmitPostField?
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Title", text: .constant("Title"),
                  prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: .constant("Title"),
            focusedField: $focusedField,
            field: SubmitPostField.title
        ))
        .padding()
    }
}
