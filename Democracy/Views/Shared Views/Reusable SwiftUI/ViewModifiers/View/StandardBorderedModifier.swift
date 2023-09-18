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
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            if let title {
                Text(title)
                    .foregroundStyle(Color.secondaryText)
            }
            
            content
                .foregroundStyle(Color.secondaryText)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.primaryText, lineWidth: 1)
                )
        }
    }
}

extension View {
    
    func standardTextField(title: String? = nil) -> some View {
        modifier(StandardBorderedModifier(title: title))
    }
}
