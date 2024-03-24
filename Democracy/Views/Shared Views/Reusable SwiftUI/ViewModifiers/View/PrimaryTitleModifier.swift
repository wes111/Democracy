//
//  PrimaryTitleModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/23/24.
//

import SwiftUI

struct PrimaryTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(.title, weight: .semibold))
            .foregroundColor(.primaryText)
    }
}

// MARK: - View Extension
extension View {
    func primaryTitle() -> some View {
        self.modifier(PrimaryTitleModifier())
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea(.all)
        Text("Hello World")
            .primaryTitle()
    }
}
