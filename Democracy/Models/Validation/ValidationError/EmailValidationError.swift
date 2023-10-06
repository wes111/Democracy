//
//  EmailValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

enum EmailValidationError: ValidationError {
    
    case invalidEmail
    
    var descriptionText: String {
        switch self {
        case .invalidEmail: "Email format is invalid."
        }
    }
    
    var regex: String {
        switch self {
        case .invalidEmail: CreateEmailField.fullRegex
        }
    }
}
