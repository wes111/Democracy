//
//  VerifyEmailField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

struct VerifyEmailField: UserInputField {
    let title: String = "Verify Email"
    let subtitle: String = "Enter the code we sent to your email to verify your email."
    let fieldTitle: String = "Email Code"
    let maxCharacterCount: Int = 1_000 //TODO: Verify this is long enough
    let errors = VerifyEmailCodeValidationError.allCases
    let alertTitle = "Invalid email verification code"
    let alertDescription = "Enter a valid email verification code."
    
    /// String has at least one character, excluding newline.
    static let fullRegex: String = #"^.+$"#
}
