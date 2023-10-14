//
//  VerifyPhoneCodeValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

enum VerifyPhoneCodeValidationError: ValidationError {
    case nonEmpty
    
    var descriptionText: String {
        switch self {
        case .nonEmpty:
            "Missing phone verification code."
        }
    }
    
    var regex: String {
        switch self {
        /// String has at least one character, excluding newline.
        case .nonEmpty:
            #"^.+$"#
        }
    }
}
