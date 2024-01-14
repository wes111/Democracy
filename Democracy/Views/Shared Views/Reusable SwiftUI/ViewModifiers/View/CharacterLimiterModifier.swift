//
//  CharacterLimiterModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import Combine
import SwiftUI

// https://stackoverflow.com/questions/56476007/swiftui-textfield-max-length
extension View {
    func limitCharacters(text: Binding<String>, count: Int) -> some View {
        modifier(CharacterLimiterModifier(text: text, limit: count))
    }
}

struct CharacterLimiterModifier: ViewModifier {
    @Binding var text: String
    let limit: Int
    
    func body(content: Content) -> some View {
        content
            .onReceive(Just(text)) { _ in limitText(limit) }
    }
    
    private func limitText(_ upper: Int) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
}

#Preview {
    ZStack {
        Color.primaryBackground
        TextField("Preview", text: .constant("BadTest"))
            .limitCharacters(text: .constant("Bad"), count: 25)
    }
}
