//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

enum TextInput {
    case field, editor
}

/// Standard shared appearance of TextFields and TextEditors.
struct StandardTextInputModifier: ViewModifier {
    @Binding var text: String
    let maxCharacterCount: Int
    let inputType: TextInput
    
    func body(content: Content) -> some View {
        Group {
            switch inputType {
            case .field:
                content
                    .padding(5)
                    .background(Color.white.opacity(0.1))
                    .trimWhiteSpace(text: $text)
                
            case .editor:
                content
                    .padding(15)
                    .background(Color.white.opacity(0.1))
            }
        }
        .foregroundStyle(Color.primaryText)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        .limitCharacters(text: $text, count: maxCharacterCount)

    }
}

extension View {
    
    func standardTextInputAppearance(
        text: Binding<String>,
        maxCharacterCount: Int,
        inputType: TextInput = .field
    ) -> some View {
        modifier(StandardTextInputModifier(
            text: text,
            maxCharacterCount: maxCharacterCount, inputType: inputType
        ))
    }
}
