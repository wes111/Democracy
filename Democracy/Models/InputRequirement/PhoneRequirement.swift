//
//  PhoneValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

enum PhoneRequirement: InputRequirement {
    case length
    
    static var fieldTitle: String = "Phone"
}

// MARK: - Computed Properties
extension PhoneRequirement {
    
    static var maxCharacterCount: Int {
        14
    }
    
    var descriptionText: String? {
        switch self {
        case .length:
            "10 digits"
        }
    }
    
    var regex: String {
        switch self {
            
        /// The string must be 10 characters long.
        case .length:
            "^\\d{14}$"
        }
    }
}

// TODO: Might need this regex?
/// Must be 10 digits long.
// "\\(\\d{3}\\) \\d{3}-\\d{4}"
