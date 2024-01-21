//
//  TrimWhiteSpaceCharactersModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/20/23.
//

import Combine
import SwiftUI

extension View {
    func trimWhiteSpace(text: Binding<String>) -> some View {
        modifier(TrimWhiteSpaceCharactersModifier(text: text))
    }
}

struct TrimWhiteSpaceCharactersModifier: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(text), perform: { _ in
                text = text.trimmingCharacters(in: .whitespacesAndNewlines)
            })
    }
}
