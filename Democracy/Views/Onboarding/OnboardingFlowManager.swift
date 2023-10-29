//
//  OnboardingManager.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/15/23.
//

import Factory
import Foundation

protocol OnboardingFlowManagerProtocol: ObservableObject {
    func submit(input: String, field: OnboardingInputField) async throws
    func acceptTerms() async throws
    func getSubmittedValue(field: OnboardingInputField) -> String?
}

// Shared state/functionality among the onboarding view flow
// with scope matching the onboarding coordinator.
final class OnboardingFlowManager: OnboardingFlowManagerProtocol {
    
    @Injected(\.accountService) private var accountService
    
    // The dictionary's values are the submitted user input for the field.
    private var submittedFieldsDictionary: [OnboardingInputField: String] = [:]
    
    func submit(input: String, field: OnboardingInputField) async throws {
        guard field.fullyValid(input: input) else {
            throw OnboardingError.invalidField
        }
        submittedFieldsDictionary[field] = input
    }
    
    // At this point we can create the account and log-in.
    func acceptTerms() async throws {
        guard let userName = submittedFieldsDictionary[.username],
              let password = submittedFieldsDictionary[.password],
              let email = submittedFieldsDictionary[.email]
        else {
            throw OnboardingError.createAccountMissingField
        }
        try await accountService.createUser(userName: userName, password: password, email: email)
        try await accountService.login(email: email, password: password)
        
        if let stringPhone = submittedFieldsDictionary[.phone], let intPhone = Int(stringPhone) {
            try await accountService.updatePhone(phone: .init(base: intPhone), password: password)
        }
        
    }
    
    func getSubmittedValue(field: OnboardingInputField) -> String? {
        submittedFieldsDictionary[field] ?? nil
    }
}
