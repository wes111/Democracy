//
//  EmailValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

struct EmailValidator: InputValidator {
    typealias Requirement = EmailRequirement
    static var field: OnboardingInputField = .email
}
