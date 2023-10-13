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
    var field: CreatePasswordField = .init()
    var topButtons: [OnboardingTopButton] = [.back, .close]
}

struct UsernameOnboarding: OnboardingCreatable {
    typealias Field = CreateUsernameField
    var field: CreateUsernameField = .init()
    var topButtons: [OnboardingTopButton] = [.close]
}

struct EmailOnboarding: OnboardingCreatable {
    typealias Field = CreateUsernameField
    var field: CreateUsernameField = .init()
    var topButtons: [OnboardingTopButton] = [.close]
}
