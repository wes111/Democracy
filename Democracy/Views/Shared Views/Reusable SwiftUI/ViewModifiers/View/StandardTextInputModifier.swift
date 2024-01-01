//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

/// Standard shared appearance of TextFields and TextEditors.
struct StandardTextInputModifier: ViewModifier {
    @Binding var text: String
    let maxCharacterCount: Int
    let shouldTrimWhileTyping: Bool
    let isTextField: Bool // Either textField or textEditor
    
    func body(content: Content) -> some View {
        Group {
            if shouldTrimWhileTyping {
                content
                    .trimWhiteSpace(text: $text)
            } else {
                content
            }
        }
        .font(.system(.body, weight: .regular))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .foregroundStyle(Color.primaryText)
        .padding(isTextField ? 17.5 : 15)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: ViewConstants.cornerRadius, style: .circular))
        .limitCharacters(text: $text, count: maxCharacterCount)
    }
}

extension View {
    
    func standardTextInputAppearance(
        text: Binding<String>,
        maxCharacterCount: Int,
        shouldTrimWhileTyping: Bool = true,
        isTextField: Bool = true
    ) -> some View {
        modifier(StandardTextInputModifier(
            text: text,
            maxCharacterCount: maxCharacterCount,
            shouldTrimWhileTyping: shouldTrimWhileTyping,
            isTextField: isTextField
        ))
    }
}
