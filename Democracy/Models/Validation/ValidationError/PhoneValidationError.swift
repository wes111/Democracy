//
//  PhoneValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

enum PhoneValidationError: ValidationError {
    case onlyDigits, length
    
    var descriptionText: String {
        switch self {
        case .onlyDigits:
            "Phone number can only contain digits."
        case .length:
            "Phone number must be 10 digits long."
        }
    }
    
    var regex: String {
        switch self {
        /// The string can only contain digits.
        case .onlyDigits:
            "^\\d+$"
            
        /// The string must be 10 characters in length.
        case .length:
            "^\\d{10}$"
        }
    }
}
