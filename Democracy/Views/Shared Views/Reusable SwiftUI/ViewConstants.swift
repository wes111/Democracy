//
//  ViewConstants.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

enum ViewConstants {
    // Element Spacing
    static let extraSmallElementSpacing: CGFloat = 5
    static let smallElementSpacing: CGFloat = 10
    static let elementSpacing: CGFloat = 20
    static let mediumElementSpacing: CGFloat = 30
    static let largeElementSpacing: CGFloat = 50
    
    // Padding between element and element's border
    static let innerBorder: CGFloat = 20
    static let smallInnerBorder: CGFloat = 10
    
    // Animation Constants
    static let animationLength = 0.3
    
    // Other standard values
    static let cornerRadius: CGFloat = 10
    static let screenPadding: CGFloat = 15
    static let borderWidth: CGFloat = 3
    static let smallButtonRadius: CGFloat = 35
}

// SF Symbols
enum SystemImage: String {
    case checkmarkCircleFill = "checkmark.circle.fill"
    case arrowRight = "arrow.right"
    case asterisk = "asterisk"
    case exclamationmarkTriangle = "exclamationmark.triangle"
    case exclamationmarkTriangleFill = "exclamationmark.triangle.fill"
    case xCircle = "x.circle"
    case ellipsis
}
