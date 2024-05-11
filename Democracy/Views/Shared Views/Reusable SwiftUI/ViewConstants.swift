//
//  ViewConstants.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

// TODO: update to 4, 8, 12, 16, 20, 24, 28, 32, etc...
enum ViewConstants {
    // Element Spacing
    static let extraSmallElementSpacing: CGFloat = 4
    static let smallElementSpacing: CGFloat = 8
    static let elementSpacing: CGFloat = 12
    static let largeElementSpacing: CGFloat = 16
    static let extraLargeElementSpacing: CGFloat = 20
    
    // Section Spacing
    static let sectionSpacing: CGFloat = 15
    static let sectionIndent: CGFloat = 20
    
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
    case arrowRight = "arrow.right"                                    // 􀄫
    case arrowshapeUp = "arrowshape.up"                                // 􁾨
    case arrowshapeDown = "arrowshape.down"                            // 􁾬
    case arrowshapeTurnUpLeft = "arrowshape.turn.up.left"              // 􀉌
    case asterisk = "asterisk"                                         // 􀸓
    case bolt                                                          // 􀋥
    case book                                                          // 􀉚
    case bookClosed = "book.closed"                                    // 􀤞
    case booksVerticalFill = "books.vertical.fill"                     // 􀬓
    case checkmark                                                     // 􀆅
    case checkmarkCircleFill = "checkmark.circle.fill"                 // 􀁣
    case checkmarkDiamondFill = "checkmark.diamond.fill"               // 􁁛
    case chevronRight = "chevron.right"                                // 􀆊
    case chevronDown = "chevron.down"                                  // 􀆈
    case chevronUp = "chevron.up"                                      // 􀆇
    case crown                                                         // 􀦅
    case ellipsis                                                      // 􀍠
    case eye                                                           // 􀋭
    case eyeSlash = "eye.slash"                                        // 􀋯
    case exclamationmarkTriangle = "exclamationmark.triangle"          // 􀇾
    case exclamationmarkTriangleFill = "exclamationmark.triangle.fill" // 􀇿
    case figureAndChildHoldingHands = "figure.and.child.holdinghands"  // 􁘁
    case infoCircle = "info.circle"                                    // 􀅴
    case laptopComputer = "laptopcomputer"                             // 􀟛
    case link                                                          // 􀉣
    case movieClapper = "movieclapper"                                 // 􀜤
    case newspaperFill = "newspaper.fill"                              // 􀥅
    case person                                                        // 􀉩
    case personThree = "person.3"                                      // 􀝊
    case shuffle                                                       // 􀊝
    case starFill = "star.fill"                                        // 􀋃
    case squareAndArrowUp = "square.and.arrow.up"                      // 􀈂
    case xCircle = "x.circle"                                          // 􀀲
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
