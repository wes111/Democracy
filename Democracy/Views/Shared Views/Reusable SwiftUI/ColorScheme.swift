//
//  ColorScheme.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/10/24.
//

import SwiftUI

struct ColorScheme { // TODO: Add all options
    let secondaryText: Color
    let primaryBackground: Color
    let tertiaryText: Color
    let onBackground: Color
    
    init(
        secondaryText: Color = .secondaryText,
        primaryBackground: Color = .primaryBackground,
        tertiaryText: Color = .tertiaryText,
        onBackground: Color = .onBackground
    ) {
        self.secondaryText = secondaryText
        self.primaryBackground = primaryBackground
        self.tertiaryText = tertiaryText
        self.onBackground = onBackground
    }
    
    static let sheetColorScheme: ColorScheme = .init(
        secondaryText: .secondaryText,
        primaryBackground: .secondaryBackground,
        tertiaryText: .tertiaryText,
        onBackground: .tertiaryBackground
    )
}
