//
//  ValidatableOnboardingField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/18/23.
//

import Foundation

protocol ValidatableOnboardingField: Hashable {
    associatedtype Requirement: InputRequirement
    static var field: OnboardingInputField { get }
}

struct EmailValidator: ValidatableOnboardingField {
    typealias Requirement = EmailRequirement
    static var field: OnboardingInputField = .email
}

struct UsernameValidator: ValidatableOnboardingField {
    typealias Requirement = UsernameRequirement
    static var field: OnboardingInputField = .username
}

struct PasswordValidator: ValidatableOnboardingField {
    typealias Requirement = PasswordRequirement
    static var field: OnboardingInputField = .password
}

struct PhoneValidator: ValidatableOnboardingField {
    typealias Requirement = PhoneRequirement
    static var field: OnboardingInputField = .phone
}
