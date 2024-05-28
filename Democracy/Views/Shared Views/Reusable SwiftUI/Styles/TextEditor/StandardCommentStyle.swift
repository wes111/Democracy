//
//  StandardCommentStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/28/24.
//

import SwiftUI

extension TextEditor {
    
    func standarCommentStyle<Field: Hashable>(
        field: Field,
        text: Binding<String>,
        focusedField: FocusState<Field?>.Binding,
        placeHolder: String
    ) -> some View {
        
        ZStack(alignment: .topLeading) {
            self
                .standardTextInputAppearance(
                    text: text,
                    focusedField: focusedField,
                    field: field,
                    shouldTrimWhileTyping: false,
                    isTextField: .smallTextInput
                )
                .standardCommentTextEditor()
            
            if text.wrappedValue.isEmpty {
                TextEditor(text: .constant(placeHolder))
                    .font(.system(.body, weight: .regular))
                    .foregroundStyle(Color.primaryText)
                    .padding(TextInputPadding.smallTextInput.value)
                    .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius, style: .circular))
                    .disabled(true)
                    .standardCommentTextEditor()
            }
        }
    }
}

// MARK: - Helper Modifier
private struct StandardCommentTextEditorModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scrollContentBackground(.hidden)
            .cornerRadius(ViewConstants.cornerRadius)
            .frame(minHeight: 50, maxHeight: 200)
            .fixedSize(horizontal: false, vertical: true)
    }
}

private extension View {
    func standardCommentTextEditor() -> some View {
        modifier(StandardCommentTextEditorModifier())
    }
}
