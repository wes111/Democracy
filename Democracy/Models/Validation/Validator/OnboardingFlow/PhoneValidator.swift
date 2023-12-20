//
//  PhoneValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

struct PhoneValidator: InputValidator {
    typealias Requirement = PhoneRequirement
    static var field: OnboardingInputField = .phone
}
