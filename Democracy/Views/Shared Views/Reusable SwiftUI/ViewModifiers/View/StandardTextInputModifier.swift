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
    let shouldTrimWhiteSpace: Bool
    let isTextField: Bool // Either textField or textEditor
    
    func body(content: Content) -> some View {
        Group {
            if shouldTrimWhiteSpace {
                content
                    .trimWhiteSpace(text: $text)
            } else {
                content
            }
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .foregroundStyle(Color.primaryText)
        .padding(isTextField ? 17.5 : 15)
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        .limitCharacters(text: $text, count: maxCharacterCount)
    }
}

extension View {
    
    func standardTextInputAppearance(
        text: Binding<String>,
        maxCharacterCount: Int,
        shouldTrimWhiteSpace: Bool = true,
        isTextField: Bool = true
    ) -> some View {
        modifier(StandardTextInputModifier(
            text: text,
            maxCharacterCount: maxCharacterCount,
            shouldTrimWhiteSpace: shouldTrimWhiteSpace,
            isTextField: isTextField
        ))
    }
}
