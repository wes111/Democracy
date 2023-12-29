//
//  DefaultTextEditorStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/18/23.
//

import Foundation
import SwiftUI

// Need to get the initial value of geo reader.

extension TextEditor {
    
    private static let minFrameHeight: CGFloat = 200.0
    
    func defaultStyle(text: Binding<String>, maxCharacterCount: Int) -> some View {
        GeometryReader { geometry in
            self
                .standardTextInputAppearance(
                    text: text,
                    maxCharacterCount: maxCharacterCount,
                    shouldTrimWhiteSpace: false,
                    isTextField: false
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
