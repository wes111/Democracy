//
//  CreatePasswordField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

struct CreatePasswordField: UserInputField {
    
    let title: String = "Create Password"
    let subtitle: String = "Create a password that will be difficult to guess."
    let fieldTitle: String = "Password"
    let maxCharacterCount: Int = 128 /// Not an Appwrite requirement.
    let errors = PasswordValidationError.allCases
    
    /// Requires at least one uppercase letter (A-Z).
    /// Requires at least one lowercase letter (a-z).
    /// Requires at least one digit (0-9).
    /// Requires at least one special character from the provided set: [@, #, $, %, ^, &, +, =, _]
    /// At least 8 characters long and at most 128 characters long.
    static let fullRegex: String = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=_])[A-Za-z\\d@#$%^&+=_]{8,128}$"
}
