//
//  LinkTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/24.
//

import SwiftUI

struct LinkTextFieldStyle<Flow: InputFlow>: TextFieldStyle {
    @Binding var link: String
    @FocusState.Binding var focusedField: Flow?
    let field: Flow
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.URL)
            .standardTextInputAppearance(
                text: $link,
                focusedField: $focusedField,
                field: field
            )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: SubmitPostFlow?
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Link", text: .constant("Link"),
                  prompt: Text("Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(LinkTextFieldStyle(
            link: .constant("Link"),
            focusedField: $focusedField,
            field: SubmitPostFlow.primaryLink
        ))
        .padding()
    }
}
