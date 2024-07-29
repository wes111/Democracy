//
//  Color+Extensions.swift
//  Democracy
//
//  Created by Wesley Luntsford on 5/7/23.
//

import Foundation
import SwiftUI

public extension Color {
    
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}

extension Color {
    
    // MARK: - Background Colors
    
    /// Dark gray.
    static var primaryBackground: Color {
        .black //.init(red: 30 / 255, green: 30 / 255, blue: 30 / 255)
    }
    
    // Deep red
    static var sheetBackground: Color {
        .init(red: 30 / 255, green: 30 / 255, blue: 30 / 255) // .init(red: 50 / 255, green: 4 / 255, blue: 4 / 255)
        // .black//.init(red: 45 / 255, green: 45 / 255, blue: 45 / 255)
    }
    
    static var secondarySheetBackground: Color {
        .init(red: 85 / 255, green: 4 / 255, blue: 4 / 255)
    }
    
    /// Medium gray.
    static var secondaryBackground: Color {
        .init(red: 65 / 255, green: 65 / 255, blue: 65 / 255)
    }
    
    /// Medicum dark gray.
    static var tertiaryBackground: Color {
        .init(red: 93 / 255, green: 93 / 255, blue: 93 / 255)
    }
    
    // MARK: - Label Colors
    
    // MARK: - Text Colors
    
    static var primaryText: Color {
        .init(red: 238  / 255, green: 238  / 255, blue: 238  / 255)
    }
    
    static var secondaryText: Color {
        .init(red: 208 / 255, green: 208 / 255, blue: 208 / 255)
    }
    
    static var tertiaryText: Color {
        .init(red: 188 / 255, green: 188 / 255, blue: 188 / 255)
    }
    
    // MARK: - Other
    static var otherRed: Color {
        .init(red: 165 / 255, green: 4 / 255, blue: 4 / 255)
    }
    
    static var onBackground: Color {
        Color.white.opacity(0.1)
    }
    
}
