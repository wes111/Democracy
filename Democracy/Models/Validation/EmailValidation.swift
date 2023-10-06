//
//  EmailValidation.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

enum EmailValidation: Validator {
    static var field: CreateField = .email
    
    case invalidEmail
    
    /// Local part:
    ///     Must start with a character that is either an uppercase letter (A-Z), lowercase letter (a-z), digit (0-9), percent sign (%), plus sign (+), or hyphen (-).
    ///     Followed by zero or more occurrences of characters that are either uppercase letters (A-Z), lowercase letters (a-z), digits (0-9), dots (.), underscores, percent signs (%), plus signs (+), or hyphens (-).
    /// @ symbol:
    ///     The email address must contain exactly one "@" symbol.
    /// Domain name:
    ///     Must consist of one or more characters.
    ///     Allowed characters are: uppercase letters (A-Z), lowercase letters (a-z), digits (0-9), dots (.), and hyphens (-).
    ///     Dots must not be adjacent to each other.
    /// Dot after Domain:
    ///     The email address must contain exactly one dot (.) after the "@" symbol.
    /// Top-Level Domain (TLD):
    ///     Must consist of at least two characters.
    ///     Allowed characters are: uppercase and lowercase letters (A-Z, a-z).
    static var fullRegex = "^[A-Z0-9a-z%+-][A-Z0-9a-z._%+-]*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*\\.[A-Za-z]{2,}$"
    
    static var maxCharacterCount: Int = 128
    
    var description: String {
        switch self {
            
        case .invalidEmail:
            "Email format is invalid."
        }
    }
    
    var regex: String {
        switch self {
        case .invalidEmail: Self.fullRegex
        }
    }
}
