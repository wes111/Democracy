//
//  PhoneValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

enum PhoneRequirement: InputRequirement {
    case length
    
    var descriptionText: String {
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
