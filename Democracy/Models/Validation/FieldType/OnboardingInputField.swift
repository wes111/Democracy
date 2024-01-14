//
//  OnboardingInputField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/18/23.
//

import Foundation

protocol InputField: Hashable {
    associatedtype AlertModel: AlertModelProtocol
    
    var title: String { get }
    var subtitle: String { get }
    var fieldTitle: String { get }
    var required: Bool { get }
    var maxCharacterCount: Int { get }
    var fullRegex: String { get }
    var alert: AlertModel { get }
}

extension InputField {
    func fullyValid(input: String) -> Bool {
        NSPredicate.validate(string: input, regex: fullRegex)
    }
    
    // Returns an array of errors corresponding to the unmet requirements of the fullRegex.
    func getInputValidationErrors<T: InputRequirement>(input: String) -> [T] {
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

enum OnboardingInputField: InputField {
    case username, password, email, phone
}

// MARK: - Computed Properties
extension OnboardingInputField {
    
    var title: String {
        switch self {
        case .username:
            "Create a Username"
        case .password:
            "Create a Password"
        case .email:
            "Add Your Email"
        case .phone:
            "Add Your Phone Number"
        }
    }
    
    var subtitle: String {
        switch self {
        case .username:
            "Create a unique username for your account."
        case .password:
            "Create a password that meets the password requirements listed below."
        case .email:
            "Add a primary email for your account."
        case .phone:
            "Add a phone number to receive SMS notifications."
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
            "Phone Number"
        }
    }
    
    var required: Bool {
        switch self {
        case .username, .password, .email:
            true
        case .phone:
            false
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
            14
        }
    }
    
    var alert: OnboardingAlert {
        switch self {
        case .username:
            .invalidUsername
        case .password:
            .invalidPassword
        case .email:
            .invalidEmail
        case .phone:
            .invalidPhone
        }
    }
    
    var fullRegex: String {
        switch self {
        case .username:
            /// Required to start with an alphanumeric character.
            /// Can be followed by up to 35 characters, which can be alphanumeric, 
            /// dots, underscores, or hyphens.
            "^[a-zA-Z0-9][a-zA-Z0-9._-]{0,35}$"
            
        case .password:
            /// Requires at least one uppercase letter (A-Z).
            /// Requires at least one lowercase letter (a-z).
            /// Requires at least one digit (0-9).
            /// Requires at least one special character from the provided set:
            /// [@, #, $, %, ^, &, +, =, _, !, ~, (, ), [, ], {, }, |, ;, :, ,, ., <, >, ?, /, \]
            /// At least 8 characters long and at most 128 characters long.
            "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@#\\$%&+=_!~*,()\\[\\]{}|;:.<>?/\\\\])[A-Za-z\\d@#\\$%&+=_!~*,()\\[\\]{}|;:.<>?/\\\\]{8,128}$"
            // swiftlint:disable:previous line_length
            
        case .email:
            /// Local part:
            ///     Must start with a character that is either an uppercase letter (A-Z), 
            ///     lowercase letter (a-z), digit (0-9), percent sign (%), plus sign (+), or hyphen (-).
            ///     Followed by zero or more occurrences of characters that are either 
            ///     uppercase letters (A-Z), lowercase letters (a-z), digits (0-9), dots (.), underscores,
            ///     percent signs (%), plus signs (+), or hyphens (-).
            /// @ symbol:
            ///     The email address must contain exactly one "@" symbol.
            /// Domain name:
            ///     Must consist of one or more characters.
            ///     Allowed characters are: uppercase letters (A-Z), lowercase letters (a-z), 
            ///     digits (0-9), dots (.), and hyphens (-).
            ///     Dots must not be adjacent to each other.
            /// Dot after Domain:
            ///     The email address must contain exactly one dot (.) after the "@" symbol.
            /// Top-Level Domain (TLD):
            ///     Must consist of at least two characters.
            ///     Allowed characters are: uppercase and lowercase letters (A-Z, a-z).
            "^[A-Z0-9a-z%+-][A-Z0-9a-z._%+-]*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*\\.[A-Za-z]{2,}$"
            
        case .phone:
            /// Must be 10 digits long.
            "\\(\\d{3}\\) \\d{3}-\\d{4}"
        }
    }
}

// MARK: PasswordCaseRepresentable
extension OnboardingInputField: PasswordCaseRepresentable {
    var isPasswordCase: Bool {
        switch self {
        case .username, .email, .phone:
            return false
        case .password:
            return true
        }
    }
    
    static var passwordCase: OnboardingInputField {
        Self.password
    }
}
