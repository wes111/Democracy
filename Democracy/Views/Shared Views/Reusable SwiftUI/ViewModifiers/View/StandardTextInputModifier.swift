//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

/// Standard shared appearance of TextFields and TextEditors.
struct StandardTextInputModifier<Field: Hashable>: ViewModifier {
    @Binding var text: String
    @FocusState.Binding var focusedField: Field?
    let field: Field
    let shouldTrimWhileTyping: Bool
    let isTextField: Bool // Either textField or textEditor
    let maxCharacterCount: Int
    
    init(
        text: Binding<String>,
        focusedField: FocusState<Field?>.Binding,
        field: Field,
        shouldTrimWhileTyping: Bool,
        isTextField: Bool,
        maxCharacterCount: Int
    ) {
        self._text = text
        self._focusedField = focusedField
        self.field = field
        self.shouldTrimWhileTyping = shouldTrimWhileTyping
        self.isTextField = isTextField
        self.maxCharacterCount = maxCharacterCount
    }
    
    func body(content: Content) -> some View {
        content
            .if(shouldTrimWhileTyping) { view in
                view.trimWhiteSpace(text: $text)
            }
            .font(.system(.body, weight: .regular))
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .foregroundStyle(Color.primaryText)
            .padding(isTextField ? 17.5 : 15)
            .background(Color.onBackground)
            .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius, style: .circular))
            .limitCharacters(text: $text, count: maxCharacterCount)
            .focused($focusedField, equals: field)
            .submitLabel(.next)
            .onTapGesture {
                focusedField = field
            }
    }
}

// MARK: - View Extension
extension View {
    
    func standardTextInputAppearance<Field: Hashable>(
        text: Binding<String>,
        focusedField: FocusState<Field?>.Binding,
        field: Field,
        shouldTrimWhileTyping: Bool = true,
        isTextField: Bool = true
    ) -> some View {
        modifier(StandardTextInputModifier(
            text: text,
            focusedField: focusedField,
            field: field,
            shouldTrimWhileTyping: shouldTrimWhileTyping,
            isTextField: isTextField,
            maxCharacterCount: 100
        ))
    }
}
