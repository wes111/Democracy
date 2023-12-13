//
//  UserNameValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

enum UsernameValidationError: ValidationError {
    
    case length, startChar, validChars
    
    var descriptionText: String {
        switch self {
        case .length:
            "1-36 characters"
        case .startChar:
            "Must begin with an alphanumeric character"
        case .validChars:
            "May only contain alphanumeric characters, dots, underscores, and hyphens"
        }
    }
    
    var regex: String {
        switch self {
        /// The string can be between 1 and 36 characters in length.
        case .length: "^.{1,36}$"
            
        /// Required to start with an alphanumeric character.
        /// Can be followed by zero or more of any characters.
        case .startChar: "^[a-zA-Z0-9].*"
            
        /// The entire string must consist of one or more characters that are either
        ///  alphanumeric, dots, underscores, or hyphens.
        case .validChars: "^[a-zA-Z0-9._-]+$"
        }
    }
}
