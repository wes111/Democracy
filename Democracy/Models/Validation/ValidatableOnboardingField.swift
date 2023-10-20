//
//  ValidatableOnboardingField.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/18/23.
//

import Foundation

protocol ValidatableOnboardingField: Hashable {
    associatedtype Error: ValidationError
    static var field: OnboardingInputField { get }
}

struct EmailValidator: ValidatableOnboardingField {
    typealias Error = EmailValidationError
    static var field: OnboardingInputField = .email
}

struct UsernameValidator: ValidatableOnboardingField {
    typealias Error = UsernameValidationError
    static var field: OnboardingInputField = .username
}

struct PasswordValidator: ValidatableOnboardingField {
    typealias Error = PasswordValidationError
    static var field: OnboardingInputField = .password
}

struct PhoneValidator: ValidatableOnboardingField {
    typealias Error = PhoneValidationError
    static var field: OnboardingInputField = .phone
}

struct VerifyEmailValidator: ValidatableOnboardingField {
    typealias Error = VerifyEmailCodeValidationError
    static var field: OnboardingInputField = .verifyEmail
}

struct VerifyPhoneValidator: ValidatableOnboardingField {
    typealias Error = VerifyPhoneCodeValidationError
    static var field: OnboardingInputField = .verifyPhone
}
