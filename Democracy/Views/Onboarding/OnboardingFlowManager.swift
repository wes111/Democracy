//
//  OnboardingManager.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/15/23.
//

import Foundation

// Shared state/functionality among the onboarding view flow
// with scope matching the onboarding coordinator.
final class OnboardingFlowManager: ObservableObject {
    
    private var acceptedTerms = false
    // The dictionary's keys are the field ids.
    // The dictionary's values are the submitted user input for the field.
    private var submittedFieldsDictionary: [String: String?] = [:]
    
    func submit<T: UserInputField>(input: String, field: T) throws {
        guard field.fullyValid(input: input) else {
            throw OnboardingError.invalidField
        }
        submittedFieldsDictionary[field.id] = input
    }
    
    func acceptTerms() {
        acceptedTerms = true
    }
}
