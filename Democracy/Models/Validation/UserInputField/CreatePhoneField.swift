//
//  CreatePhoneField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/13/23.
//

import Foundation

struct CreatePhoneField: UserInputField {
    
    let title: String = "Create Phone"
    let subtitle: String = "Create a phone number we can contact you via SMS"
    let fieldTitle: String = "Phone"
    let maxCharacterCount: Int = 10 //TODO: Is this correct
    let errors = PhoneValidationError.allCases
    
    /// Must be 10 digits long.
    static let fullRegex = #"^\d{10}$"#
}
