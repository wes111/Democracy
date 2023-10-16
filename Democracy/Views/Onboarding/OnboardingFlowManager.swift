//
//  OnboardingManager.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/15/23.
//

import Factory
import Foundation

// Shared state/functionality among the onboarding view flow
// with scope matching the onboarding coordinator.
final class OnboardingFlowManager: ObservableObject {
    
    @Injected(\.accountService) private var accountService
    
    // The dictionary's keys are the field ids.
    // The dictionary's values are the submitted user input for the field.
    private var submittedFieldsDictionary: [String: String] = [:]
    
    func submit<T: UserInputField>(input: String, field: T) throws {
        guard field.fullyValid(input: input) else {
            throw OnboardingError.invalidField
        }
        submittedFieldsDictionary[field.id] = input
    }
    
    //At this point we can create the account.
    func acceptTerms() async throws {
        //TODO: Make id static?
        guard let userName = submittedFieldsDictionary[CreateUsernameField().id],
              let password = submittedFieldsDictionary[CreatePasswordField().id],
              let email = submittedFieldsDictionary[CreateEmailField().id]
        else {
            throw OnboardingError.createAccountMissingField
        }
        
        try await accountService.createUser(userName: userName, password: password, email: email)
    }
    
    func getSubmittedValue<T: UserInputField>(field: T) -> String? {
        submittedFieldsDictionary[field.id] ?? nil
    }
    
}
