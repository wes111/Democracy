//
//  DefaultTextEditorStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/18/23.
//

import Foundation
import SwiftUI

extension TextEditor {
    func defaultStyle(text: Binding<String>, maxCharacterCount: Int) -> some View {
        self
            .standardTextInputAppearance(text: text, maxCharacterCount: maxCharacterCount)
            .font(.system(.body, weight: .regular))
            .scrollContentBackground(.hidden)
            .lineSpacing(10)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .cornerRadius(10)
            .frame(minHeight: 200)
        // TODO: Make sure modifiers are still in correct order.
    }
}
