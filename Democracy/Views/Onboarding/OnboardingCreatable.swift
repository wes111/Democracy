//
//  OnboardingCreatable.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/12/23.
//

import Foundation

/// Corresponds to a view in the Onboarding flow with a UserInputField.
protocol OnboardingCreatable {
    associatedtype Field: UserInputField
    var field: Field { get }
    var topButtons: [OnboardingTopButton] { get }
    
    init()
}

struct PasswordOnboarding: OnboardingCreatable {
    typealias Field = CreatePasswordField
    var field: Field = .init()
    var topButtons: [OnboardingTopButton] = [.back, .close]
}

struct UsernameOnboarding: OnboardingCreatable {
    typealias Field = CreateUsernameField
    var field: Field = .init()
    var topButtons: [OnboardingTopButton] = [.close]
}

struct EmailOnboarding: OnboardingCreatable {
    typealias Field = CreateEmailField
    var field: Field = .init()
    var topButtons: [OnboardingTopButton] = [.close]
}

struct PhoneOnboarding: OnboardingCreatable {
    typealias Field = CreatePhoneField
    var field: Field = .init()
    var topButtons: [OnboardingTopButton] = [.back, .close]
}

struct VerifyPhoneOnboarding: OnboardingCreatable {
    typealias Field = VerifyPhoneField
    var field: Field = .init()
    var topButtons: [OnboardingTopButton] = [.back, .close]
}

struct VerifyEmailOnboarding: OnboardingCreatable {
    typealias Field = VerifyEmailField
    var field: Field = .init()
    var topButtons: [OnboardingTopButton] = [.back, .close]
}
