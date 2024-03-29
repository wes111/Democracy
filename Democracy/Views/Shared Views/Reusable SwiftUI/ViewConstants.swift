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
    static let partialSheetTopPadding: CGFloat = 20
    static let thinBorderWidth: CGFloat = 2 // For smaller elements like tags.
    static let borderWidth: CGFloat = 3
    static let smallButtonRadius: CGFloat = 35
    static let dimmingBrightness = -0.1
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
    case chevronRight = "chevron.right"
    case personThree = "person.3"
    case person
    case figureAndChildHoldingHands = "figure.and.child.holdinghands"
    case eye
    case eyeSlash = "eye.slash"
    case booksVerticalFill = "books.vertical.fill"
    case crown
    case bolt
    case checkmark
    case book
    case bookClosed = "book.closed"
    case laptopComputer = "laptopcomputer"
    case movieClapper = "movieclapper"
    case checkmarkDiamondFill = "checkmark.diamond.fill"
}

// Image assets
enum CustomImage: String {
    case bmw = "BMW"
}

import SwiftUI
// Any SystemImage or Image Asset
enum AppImage {
    case systemImage(SystemImage)
    case customImage(CustomImage)
    
    var image: Image {
        switch self {
        case .systemImage(let systemImage):
            Image(systemName: systemImage.rawValue)
        case .customImage(let customImage):
            Image(customImage.rawValue)
        }
    }
}
