//
//  PreviewModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/18/23.
//

import SwiftUI

struct PreviewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            Color.primaryBackground
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func preview() -> some View {
        modifier(PreviewModifier())
    }
}
