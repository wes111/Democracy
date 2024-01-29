//
//  ValidationError.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Foundation

// A collection of requirements correspoding to a type of user input.
// Each requirement in the collection has a description and a regex.
protocol InputRequirement: Error, CaseIterable, Hashable {
    var descriptionText: String? { get }
    var regex: String { get }
    static var maxCharacterCount: Int { get }
    static var fieldTitle: String { get }
}

extension InputRequirement {
    
    // Returns an array of errors corresponding to the unmet requirements of the fullRegex.
    static func getInputValidationErrors(input: String) -> [Self] {
        var validationErrors: [Self] = []
        Self.allCases.forEach { validation in
            if !NSPredicate.validate(string: input, regex: validation.regex) {
                validationErrors.append(validation)
            }
        }
        return validationErrors
    }
    
    static func fullyValid(input: String) -> Bool {
        getInputValidationErrors(input: input).isEmpty
    }
    
    static var invalidAlert: NewAlertModel {
        NewAlertModel(
            title: "Invalid \(Self.fieldTitle.capitalized)",
            description: "Enter a \(Self.fieldTitle.lowercased()) that matches the requirements."
        )
    }
}
