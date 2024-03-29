//
//  PostLinkRequirement.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/2/24.
//

import Foundation

enum LinkRequirement: InputRequirement {
    case https, length
    
    static var fieldTitle: String = "Link"
}

// MARK: - Computed Properties
extension LinkRequirement {
    
    static var maxCharacterCount: Int {
        500
    }
    
    var descriptionText: String? {
        switch self {
        case .https:
            "begins with \"https://\""
            
        case .length:
            "valid length"
        }
    }
    
    var regex: String {
        switch self {
        // The String must begin with "https://"
        case .https:
            "^https://.*"
            
        // The string must be between 9 and 500 characters long.
        case .length:
            "^.{9,500}$"
        }
    }
}
