//
//  PasswordValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

struct PasswordValidator: InputValidator {
    typealias Requirement = PasswordRequirement
    static var field: OnboardingInputField = .password
}
