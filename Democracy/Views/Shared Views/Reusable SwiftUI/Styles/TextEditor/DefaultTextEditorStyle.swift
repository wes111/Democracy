//
//  DefaultTextEditorStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/18/23.
//

import Foundation
import SwiftUI

extension TextEditor {
    func defaultStyle() -> some View {
        self
            .font(.system(.body, weight: .regular))
            .foregroundStyle(Color.primaryText)
            .scrollContentBackground(.hidden)
            .lineSpacing(10)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding(10) // TODO: This needs to match TextField.
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .frame(minHeight: 200)
    }
}
