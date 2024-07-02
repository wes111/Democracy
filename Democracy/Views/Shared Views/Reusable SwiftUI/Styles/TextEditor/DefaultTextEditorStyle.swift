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
    
    func defaultStyle<Field: Hashable>(
        field: Field,
        text: Binding<String>,
        focusedField: FocusState<Field?>.Binding
    ) -> some View {
        GeometryReader { geometry in
            self
                .standardTextInputAppearance(
                    text: text,
                    focusedField: focusedField,
                    field: field,
                    shouldTrimWhileTyping: false,
                    isTextField: .standardTextEditor
                )
                .scrollContentBackground(.hidden)
                .cornerRadius(ViewConstants.cornerRadius)
                .frame(
                    minHeight: Self.minFrameHeight,
                    maxHeight: max(Self.minFrameHeight, geometry.size.height)
                )
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
