//
//  TitleTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

// TODO: Combine with below, only difference is trimming.
struct DefaultTrimmedTextFieldStyle<Field: Hashable>: TextFieldStyle {
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
                field: field
            )
    }
}

struct TitleTextFieldStyle<Field: Hashable>: TextFieldStyle {
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
    @FocusState var focusedField: SubmitPostFlow?
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Title", text: .constant("Title"),
                  prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: .constant("Title"),
            focusedField: $focusedField,
            field: SubmitPostFlow.title
        ))
        .padding()
    }
}
