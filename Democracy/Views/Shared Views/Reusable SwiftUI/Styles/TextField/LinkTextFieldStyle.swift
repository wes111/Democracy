//
//  LinkTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/24.
//

import SwiftUI

struct LinkTextFieldStyle: TextFieldStyle {
    @Binding var link: String
    @FocusState.Binding var focusedField: PostPrimaryLinkValidator.FieldCollection?
    var textErrors: [PostPrimaryLinkValidator.Requirement]
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.URL)
            .standardTextInputAppearance(
                input: PostPrimaryLinkValidator.self,
                text: $link,
                focusedField: $focusedField,
                requirements: .some(
                    allPossibleErrors: PostPrimaryLinkValidator.Requirement.allCases,
                    textErrors: textErrors
                )
            )
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: SubmitPostField?
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Link", text: .constant("Link"),
                  prompt: Text("Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(LinkTextFieldStyle(
            link: .constant("Link Text"),
            focusedField: $focusedField,
            textErrors: PostPrimaryLinkValidator.Requirement.allCases
        ))
        .padding()
    }
}
