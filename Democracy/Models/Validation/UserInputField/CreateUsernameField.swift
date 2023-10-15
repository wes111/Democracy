//
//  CreateUsernameField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

struct CreateUsernameField: UserInputField {
    let title: String = "Create Username"
    let subtitle: String = "Create a unique username as a unique identifier across the app."
    let fieldTitle: String = "Username"
    let maxCharacterCount: Int = 36 /// Appwrite requirement.
    let errors = UsernameValidationError.allCases
    let alertTitle = "Invalid username"
    let alertDescription = "Enter a username that matches the requirements."
    
    /// Required to start with an alphanumeric character.
    /// Can be followed by up to 35 characters, which can be alphanumeric, dots, underscores, or hyphens.
    static let fullRegex: String = "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,35}$"
}
