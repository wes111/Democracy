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
    
    var userName: String? { get }
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
        
        switch field {
        case .username, .password, .email:
            return
        case .phone:
            try await submitPhone()
            try await accountService.createPhoneVerification()
//        case .verifyPhone:
//            return
        case .verifyEmail:
            return //TODO: ...
        }

    }
    
    private func submitPhone() async throws {
        guard let password = submittedFieldsDictionary[.password],
              let phoneString = submittedFieldsDictionary[.phone],
              let phoneInt = Int(phoneString)
        else {
            throw OnboardingError.phoneError
        }
        
        try await accountService.updatePhone(phone: PhoneNumber(base: phoneInt), password: password)
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
    }
    
    func getSubmittedValue(field: OnboardingInputField) -> String? {
        submittedFieldsDictionary[field] ?? nil
    }
    
    var userName: String? {
        submittedFieldsDictionary[OnboardingInputField.username]
    }
}
