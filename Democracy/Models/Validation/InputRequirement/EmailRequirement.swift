//
//  EmailValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

enum EmailRequirement: InputRequirement {
    
    case invalidEmail
    
    var descriptionText: String {
        switch self {
        case .invalidEmail: "valid email format"
        }
    }
    
    var regex: String {
        switch self {
        case .invalidEmail: CreateAccountField.email.fullRegex
        }
    }
}
