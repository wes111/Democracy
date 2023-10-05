//
//  PasswordValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

enum PasswordValidation: Validator {
    case hasUppercase, hasLowercase, hasDigit, hasSpecialChar, length
    
    /// Requires at least one uppercase letter (A-Z).
    /// Requires at least one lowercase letter (a-z).
    /// Requires at least one digit (0-9).
    /// Requires at least one special character from the provided set: [@, #, $, %, ^, &, +, =, _]
    /// At least 8 characters long and at most 128 characters long.
    static let fullRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=_])[A-Za-z\\d@#$%^&+=_]{8,128}$"
    
    static let maxPasswordCharCount = 128 /// This is an app requirement, not an Appwrite requirement.
    
    var description: String {
        switch self {
        case .hasUppercase:
            "Password must have at least one uppercase letter."
        case .hasLowercase:
            "Password must have at least one lowercase letter."
        case .hasDigit:
            "Password must have at least one digit."
        case .hasSpecialChar:
            "Password must have at least one special character."
        case .length:
            "Password must be between 8 and 128 characters long."
        }
    }
    
    var regex: String {
        switch self {
            
        case .hasUppercase:
            /// At least one uppercase letter anywhere in the string.
            ".*[A-Z]+.*"
            
        case .hasLowercase:
            /// At least one lowercase letter anywhere in the string.
            ".*[a-z]+.*"
            
        case .hasDigit:
            /// At least one digit anywhere in the string.
            ".*\\d+.*"
            
        case .hasSpecialChar:
            /// Requires one or more occurrences of the following special characters: @, #, $, %, ^, &, +, =,  _
            ".*[@#$%^&+=_].*"
            
        case .length:
            /// Checks if the string is between 8 and 128 characters in length.
            "^.{8,128}$"
        }
    }
}
