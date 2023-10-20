//
//  OnboardingInputField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/18/23.
//

import Foundation

enum OnboardingInputField {
    case username, password, email, phone, verifyPhone, verifyEmail
}

// MARK: - Computed Properties
extension OnboardingInputField {
    
    var title: String {
        switch self {
        case .username:
            "Create Username"
        case .password:
            "Create Password"
        case .email:
            "Create Email"
        case .phone:
            "Create Phone"
        case .verifyPhone:
            "Verify Phone"
        case .verifyEmail:
            "Verify Email"
        }
    }
    
    var subtitle: String {
        switch self {
        case .username:
            "Create a unique username as a unique identifier across the app."
        case .password:
            "Create a password that will be difficult to guess."
        case .email:
            "Create the primary email for this account"
        case .phone:
            "Create a phone number we can contact you via SMS"
        case .verifyPhone:
            "Enter the code we sent to your phone to verify your phone."
        case .verifyEmail:
            "Enter the code we sent to your email to verify your email."
        }
    }
    
    var fieldTitle: String {
        switch self {
        case .username:
            "Username"
        case .password:
            "Password"
        case .email:
            "Email"
        case .phone:
            "Phone"
        case .verifyPhone:
            "Phone Code"
        case .verifyEmail:
            "Email Code"
        }
    }
    
    var maxCharacterCount: Int {
        switch self {
        case .username:
            36 /// Appwrite requirement.
        case .password:
            128 /// Not an Appwrite requirement.
        case .email:
            128
        case .phone:
            10 //TODO: Is this correct
        case .verifyPhone:
            1_000 //TODO: Verify this is long enough
        case .verifyEmail:
            1_000 //TODO: Verify this is long enough
        }
    }
    
    var alertTitle: String {
        switch self {
        case .username:
            "Invalid username"
        case .password:
            "Invalid password"
        case .email:
            "Invalid email"
        case .phone:
            "Invalid phone number"
        case .verifyPhone:
            "Invalid phone verification code"
        case .verifyEmail:
            "Invalid email verification code"
        }
    }
    
    var alertDescription: String {
        switch self {
        case .username:
            "Enter a username that matches the requirements."
        case .password:
            "Enter a password that matches the requirements."
        case .email:
            "Enter an email that matches the requirements."
        case .phone:
            "Enter a phone number that matches the requirements."
        case .verifyPhone:
            "Enter a valid phone verification code."
        case .verifyEmail:
            "Enter a valid email verification code."
        }
    }
    
    var fullRegex: String {
        switch self {
        case .username:
            /// Required to start with an alphanumeric character.
            /// Can be followed by up to 35 characters, which can be alphanumeric, dots, underscores, or hyphens.
            "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,35}$"
            
        case .password:
            /// Requires at least one uppercase letter (A-Z).
            /// Requires at least one lowercase letter (a-z).
            /// Requires at least one digit (0-9).
            /// Requires at least one special character from the provided set: [@, #, $, %, ^, &, +, =, _]
            /// At least 8 characters long and at most 128 characters long.
            "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#$%^&+=_])[A-Za-z\\d@#$%^&+=_]{8,128}$"
            
        case .email:
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
            "^[A-Z0-9a-z%+-][A-Z0-9a-z._%+-]*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*\\.[A-Za-z]{2,}$"
            
        case .phone:
            /// Must be 10 digits long.
            #"^\d{10}$"#
            
        case .verifyPhone:
            /// String has at least one character, excluding newline.
            #"^.+$"#
            
        case .verifyEmail:
            /// String has at least one character, excluding newline.
            #"^.+$"#
        }
    }
}

// MARK: - Methods
extension OnboardingInputField {
    
    func fullyValid(input: String) -> Bool {
        NSPredicate.validate(string: input, regex: fullRegex)
    }
    
    // Returns an array of errors corresponding to the unmet requirements of the fullRegex.
    func getInputValidationErrors<T: ValidationError>(input: String) -> [T] {
        var validationErrors: [T] = []
        if !fullyValid(input: input) {
            T.allCases.forEach { validation in
                if !NSPredicate.validate(string: input, regex: validation.regex) {
                    validationErrors.append(validation)
                }
            }
        }
        return validationErrors
    }
}
