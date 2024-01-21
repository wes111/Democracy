//
//  OnboardingCoordinatorDelegate.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/22/23.
//

import Foundation

@MainActor
protocol OnboardingCoordinatorDelegate: AnyObject {
    func didSubmitUsername(input: OnboardingInput)
    func submitPassword(input: OnboardingInput)
    func submitEmail(input: OnboardingInput)
    func agreeToTerms(username: String)
    func continueAccountSetup()
    func submitPhone(input: OnboardingInput)
    func close()
    func goBack()
}
