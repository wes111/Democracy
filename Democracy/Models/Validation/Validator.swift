//
//  Validator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

protocol Validator: CaseIterable, Hashable {
    static func fullyValid(string: String) -> Bool
    static var fullRegex: String { get }
    static var maxCharacterCount: Int { get }
    static var field: CreateField { get }
    
    var regex: String { get }
    var description: String { get }
}

extension Validator {
    static func validate(string: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: string)
    }
    
    static func fullyValid(string: String) -> Bool {
        validate(string: string, regex: Self.fullRegex)
    }
    
    static func getFieldValidationErrors<T: Validator>(fieldString: String) -> [T] {
        var validationErrors: [T] = []
        if !T.fullyValid(string: fieldString) {
            T.allCases.forEach { validation in
                if !T.validate(string: fieldString, regex: validation.regex) {
                    validationErrors.append(validation)
                }
            }
        }
        return validationErrors
    }
}

enum CreateField {
    case email, password, phone, username
    
    var title: String {
        switch self {
        case .email: "Create Email"
        case .password: "Create Password"
        case .phone: "Create Phone"
        case .username: "Create Username"
        }
    }
    
    var subtitle: String {
        switch self {
        case .email:
            "Create the primary email for this account"
        case .password:
            "Create a password that will be difficult to guess."
        case .phone:
            "Create a phone number that we can contact you at."
        case .username:
            "Create a unique username as a unique identifier across the app."
        }
    }
    
    var fieldTitle: String {
        switch self {
        case .email: "Email"
        case .password: "Password"
        case .phone: "Phone"
        case .username: "Username"
        }
    }
}
