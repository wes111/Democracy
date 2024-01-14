//
//  DefaultTextEditorStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/18/23.
//

import Foundation
import SwiftUI

extension TextEditor {
    private static let minFrameHeight: CGFloat = 200.0
    
    func defaultStyle<Input: InputValidator>(
        input: Input.Type,
        text: Binding<String>,
        focusedField: FocusState<Input.FieldCollection?>.Binding
    ) -> some View {
        GeometryReader { geometry in
            self
                .standardTextInputAppearance(
                    input: Input.self,
                    text: text,
                    focusedField: focusedField,
                    shouldTrimWhileTyping: false,
                    requirements: .none // Currently none, but could change.
                )
                .scrollContentBackground(.hidden)
                .cornerRadius(10)
                .frame(
                    minHeight: Self.minFrameHeight,
                    maxHeight: max(Self.minFrameHeight, geometry.size.height)
                )
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
