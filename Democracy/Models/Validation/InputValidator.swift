//
//  ValidatableOnboardingField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/18/23.
//

import Foundation

protocol InputValidator: Hashable {
    associatedtype Requirement: InputRequirement
    associatedtype FieldCollection: InputField
    static var field: FieldCollection { get }
}
