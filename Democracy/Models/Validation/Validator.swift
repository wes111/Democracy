//
//  Validator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/4/23.
//

import Foundation

protocol Validator: CaseIterable {
    static func fullyValid(string: String) -> Bool
    static var fullRegex: String { get }
    
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
