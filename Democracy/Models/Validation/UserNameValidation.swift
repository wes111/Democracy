//
//  UserNameValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

enum UserNameValidation: Validator {
    case length, startChar, validChars
    
    /// Required to start with an alphanumeric character.
    /// Can be followed by up to 35 characters, which can be alphanumeric, dots, underscores, or hyphens.
    static let fullRegex = "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,35}$"
    
    static let maxUsernameCharCount = 36 /// Appwrite requirement.
    
    var description: String {
        switch self {
        case .length:
            "Username must be between 1 and 36 characters long."
        case .startChar:
            "Username must start with an alphanumeric character."
        case .validChars:
            "Username contains an invalid character."
        }
    }
    
    var regex: String {
        switch self {
            
        case .length:
            /// The string can be between 1 and 36 characters in length.
            "^.{1,36}$"
            
        case .startChar:
            /// Required to start with an alphanumeric character.
            /// Can be followed by zero or more of any characters.
            "^[a-zA-Z0-9].*"
            
        case .validChars:
            /// The entire string must consist of one or more characters that are either alphanumeric, dots, underscores, or hyphens.
            "^[a-zA-Z0-9._-]+$"
        }
    }
}
