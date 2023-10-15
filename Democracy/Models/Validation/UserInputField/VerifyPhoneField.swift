//
//  VerifyPhoneField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

struct VerifyPhoneField: UserInputField {
    let title: String = "Verify Phone"
    let subtitle: String = "Enter the code we sent to your phone to verify your phone."
    let fieldTitle: String = "Phone Code"
    let maxCharacterCount: Int = 1_000 //TODO: Verify this is long enough
    let errors = VerifyPhoneCodeValidationError.allCases
    let alertTitle = "Invalid phone verification code"
    let alertDescription = "Enter a valid phone verification code."
    
    /// String has at least one character, excluding newline.
    static let fullRegex: String = #"^.+$"#
}
