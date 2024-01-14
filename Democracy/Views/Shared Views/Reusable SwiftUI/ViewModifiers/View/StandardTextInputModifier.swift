//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

/// Standard shared appearance of TextFields and TextEditors.
struct StandardTextInputModifier<Input: InputValidator>: ViewModifier {
    @Binding var text: String
    @FocusState.Binding var focusedField: Input.FieldCollection?
    let shouldTrimWhileTyping: Bool
    let isTextField: Bool // Either textField or textEditor
    var requirements: TextFieldRequirements
    
    init(
        text: Binding<String>,
        focusedField: FocusState<Input.FieldCollection?>.Binding,
        shouldTrimWhileTyping: Bool,
        isTextField: Bool,
        requirements: TextFieldRequirements
    ) {
        self._text = text
        self._focusedField = focusedField
        self.shouldTrimWhileTyping = shouldTrimWhileTyping
        self.isTextField = isTextField
        self.requirements = requirements
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
            .limitCharacters(text: $text, count: Input.field.maxCharacterCount)
            .if(shouldShowRequirements) { view in
                view.requirements(
                    text: text,
                    allPossibleErrors: requirements.errors.allPossibleErros,
                    textErrors: requirements.errors.textErrors
                )
            }
            .focused($focusedField, equals: Input.field)
            .submitLabel(.next)
            .onTapGesture {
                focusedField = Input.field
            }
    }
}

// MARK: - Computed Properties
private extension StandardTextInputModifier {
    
    var shouldShowRequirements: Bool {
        if case .none = requirements {
            return false
        } else {
            return true
        }
    }
}

// MARK: - View Extension
extension View {
    
    func standardTextInputAppearance<Input: InputValidator>(
        input: Input.Type,
        text: Binding<String>,
        focusedField: FocusState<Input.FieldCollection?>.Binding,
        shouldTrimWhileTyping: Bool = true,
        isTextField: Bool = true,
        requirements: StandardTextInputModifier<Input>.TextFieldRequirements
    ) -> some View {
        modifier(StandardTextInputModifier(
            text: text,
            focusedField: focusedField,
            shouldTrimWhileTyping: shouldTrimWhileTyping,
            isTextField: isTextField,
            requirements: requirements
        ))
    }
}

// MARK: - Helper Enum
extension StandardTextInputModifier {
    
    enum TextFieldRequirements {
        case none
        case some(allPossibleErrors: [Input.Requirement], textErrors: [Input.Requirement])
        
        var errors: (allPossibleErros: [Input.Requirement], textErrors: [Input.Requirement]) {
            switch self {
            case .none:
                ([], [])
            case .some(let allPossibleErrors, let textErrors):
                (allPossibleErrors, textErrors)
            }
        }
    }
}
