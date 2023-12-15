//
//  StandardBorderedModifier.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/17/23.
//

import Foundation
import SwiftUI

/// Currently only used for TextFields (and the TaggableModifier).
struct StandardBorderedModifier: ViewModifier {
    let title: String?
    var borderColor: Color
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            if let title {
                Text(title)
                    .font(.callout)
                    .foregroundStyle(Color.secondaryText)
            }
            content
                .foregroundStyle(Color.primaryText)
                .padding()
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        }
    }
}

extension View {
    
    func standardTextField(title: String? = nil, borderColor: Color = .secondaryBackground) -> some View {
        modifier(StandardBorderedModifier(title: title, borderColor: borderColor))
    }
}
