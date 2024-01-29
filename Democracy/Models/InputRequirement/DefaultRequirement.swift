//
//  EmptyRequirement.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/14/24.
//

import Foundation

enum DefaultRequirement: InputRequirement {
    case defaultCase
    
    static let fieldTitle: String = "Text"
}

// MARK: - Computed Properties
extension DefaultRequirement {
    
    static var maxCharacterCount: Int {
        .max
    }
    
    var descriptionText: String? {
        nil
    }
    
    // Matches any String that is at least one character long.
    var regex: String {
        "^.+"
    }
}
