//
//  DefaultTextFieldInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/13/24.
//

import SwiftUI

struct DefaultTextInputField<Requirement: InputRequirement, Style: TextFieldStyle>: View {
    @Binding var text: String
    let textFieldStyle: Style
    let fieldTitle: String
    
    init(
        text: Binding<String>,
        textFieldStyle: Style,
        fieldTitle: String,
        requirementType: Requirement.Type
    ) {
        self._text = text
        self.textFieldStyle = textFieldStyle
        self.fieldTitle = fieldTitle
    }
    
    var body: some View {
        TextField(
            fieldTitle,
            text: $text,
            prompt: Text(fieldTitle).foregroundColor(.tertiaryBackground)
        )
        .requirements(
            text: $text,
            requirementType: Requirement.self
        )
        .textFieldStyle(textFieldStyle)
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: CreateCommunityFlow?
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        DefaultTextInputField(
            text: .constant("Hello World!"),
            textFieldStyle: TitleTextFieldStyle(
                title: .constant("Community Title"),
                focusedField: $focusedField,
                field: CreateCommunityFlow.name
            ),
            fieldTitle: "Field Title",
            requirementType: EmailRequirement.self
        )
    }
}
