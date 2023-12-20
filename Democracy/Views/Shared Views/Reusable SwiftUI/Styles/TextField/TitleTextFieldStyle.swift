//
//  TitleTextFieldStyle.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct TitleTextFieldStyle: TextFieldStyle {
    @Binding var title: String
    
    // swiftlint:disable:next all
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .limitCharacters(
                text: $title,
                count: 100
            ) // TODO: Define somewhere else
            .keyboardType(.default)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .standardTextField()
            .contentShape(RoundedRectangle(cornerRadius: 10, style: .circular))
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        TextField("Title", text: .constant("Title"),
                  prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(title: .constant("Email")))
        .padding()
    }
}
