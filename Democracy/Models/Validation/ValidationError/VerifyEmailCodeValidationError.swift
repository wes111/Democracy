//
//  VerifyEmailCodeValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

enum VerifyEmailCodeValidationError: ValidationError {
    case nonEmpty
    
    var descriptionText: String {
        switch self {
        case .nonEmpty:
            "Missing email verification code."
        }
    }
    
    var regex: String {
        switch self {
        /// String has at least one character.
        case .nonEmpty:
            #"^.+$"#
        }
    }
}
