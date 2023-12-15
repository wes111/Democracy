//
//  PasswordValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

enum PasswordRequirement: InputRequirement {
    
    case hasUppercase, hasLowercase, hasDigit, hasSpecialChar, length
    
    var descriptionText: String {
        switch self {
        case .hasUppercase:
            "At least one uppercase letter."
        case .hasLowercase:
            "At least one lowercase letter."
        case .hasDigit:
            "At least one digit."
        case .hasSpecialChar:
            "At least one special character."
        case .length:
            "8-128 characters."
        }
    }
    
    var regex: String {
        switch self {
        /// At least one uppercase letter anywhere in the string.
        case .hasUppercase: ".*[A-Z]+.*"
            
        /// At least one lowercase letter anywhere in the string.
        case .hasLowercase: ".*[a-z]+.*"
            
        /// At least one digit anywhere in the string.
        case .hasDigit: ".*\\d+.*"
            
        /// Requires one or more occurrences of the following special characters:
        /// [@, #, $, %, ^, &, +, =, _, !, ~, (, ), [, ], {, }, |, ;, :, ,, ., <, >, ?, /, \]
        case .hasSpecialChar: ".*[@#$%^&+=_!~*()\\[\\]{}|;:,.<>?/\\\\].*"
            
        /// Checks if the string is between 8 and 128 characters in length.
        case .length: "^.{8,128}$"
        }
    }
}