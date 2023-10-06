//
//  Validator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

// Validates a type of user input.
protocol UserInputValidator: Hashable {
    associatedtype InputError: ValidationError
    
    // The complete regex.
    static var fullRegex: String { get }
    
    // The user's input meets the requirements of the fullRegex.
    func fullyValid(input: String) -> Bool
    
    // An array of errors corresponding to individual requirements of the fullRegex.
    var errors: [InputError] { get }
}

extension UserInputValidator {
    func fullyValid(input: String) -> Bool {
        NSPredicate.validate(string: input, regex: Self.fullRegex)
    }
    
    // Returns an array of errors corresponding to the unmet requirements of the fullRegex.
    func getInputValidationErrors(input: String) -> [InputError] {
        var validationErrors: [InputError] = []
        if !fullyValid(input: input) {
            InputError.allCases.forEach { validation in
                if !NSPredicate.validate(string: input, regex: validation.regex) {
                    validationErrors.append(validation)
                }
            }
        }
        return validationErrors
    }
}
