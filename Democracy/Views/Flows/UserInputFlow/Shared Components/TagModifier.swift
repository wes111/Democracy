//
//  TaggableModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

struct TagModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding(ViewConstants.smallInnerBorder)
            .background(backgroundColor, in: RoundedRectangle(cornerRadius: ViewConstants.cornerRadius))
            .foregroundStyle(Color.secondaryText)
    }
}

// MARK: - View Extension
extension View {
    func tagModifier(backgroundColor: Color = .onBackground) -> some View {
        modifier(TagModifier(backgroundColor: backgroundColor))
    }
}


// MARK: - Preview
#Preview {
    ZStack {
        Color.primaryBackground.ignoresSafeArea()
        Text("Tag")
            .tagModifier()
    }
}
