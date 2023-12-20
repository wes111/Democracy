//
//  UsernameValidator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/19/23.
//

import Foundation

struct UsernameValidator: InputValidator {
    typealias Requirement = UsernameRequirement
    static var field: OnboardingInputField = .username
}
