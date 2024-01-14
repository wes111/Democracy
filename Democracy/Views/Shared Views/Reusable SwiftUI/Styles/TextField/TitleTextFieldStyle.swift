//
//  TitleTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct TitleTextFieldStyle: TextFieldStyle {
    @Binding var title: String
    @FocusState.Binding var focusedField: PostTitleValidator.FieldCollection?
    var textErrors: [PostTitleValidator.Requirement]
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .keyboardType(.default)
            .standardTextInputAppearance(
                input: PostTitleValidator.self,
                text: $title,
                focusedField: $focusedField,
                requirements: .some(
                    allPossibleErrors: PostTitleValidator.Requirement.allCases,
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
        
        TextField("Title", text: .constant("Title"),
                  prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(
            title: .constant("Title Text"),
            focusedField: $focusedField,
            textErrors: PostTitleValidator.Requirement.allCases
        ))
        .padding()
    }
}
