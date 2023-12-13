//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

struct OnboardingInput {
    var password: String?
    var username: String?
    var phone: String?
    var email: String?
}

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

// TODO: The use of a single protocol here exposes too much to the view.
protocol InputViewModel: Hashable, ObservableObject {
    associatedtype Field: ValidatableOnboardingField
    var isShowingProgress: Bool { get set }
    var text: String { get set }
    var field: OnboardingInputField { get }
    var topButtons: [OnboardingTopButton: () -> Void] { get }
    var onboardingAlert: OnboardingAlert? { get set }
    var title: String { get }
    var subtitle: String { get }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
    var textErrors: [Field.Error] { get }
    var canSubmit: Bool { get }
    var coordinator: OnboardingCoordinatorDelegate? { get }
    var allErrors: [Field.Error] { get }
    
    func submit() async
    func close()
    func goBack()
    @MainActor func presentGenericAlert()
    @MainActor func presentInvalidInputAlert()
}

extension InputViewModel {
    
    var allErrors: [Field.Error] {
        Field.Error.allCases as! [Field.Error]
    }
    
    var field: OnboardingInputField {
        Field.field
    }
    
    var title: String {
        field.title
    }
    
    var subtitle: String {
        field.subtitle
    }
    
    var fieldTitle: String {
        field.fieldTitle
    }
    
    var maxCharacterCount: Int {
        field.maxCharacterCount
    }
    
    var canSubmit: Bool {
        field.fullyValid(input: text)
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
    
    @MainActor
    func presentGenericAlert() {
        onboardingAlert = .init(
            title: "Error",
            message: "An error occurred, please try again later."
        )
    }
    
    @MainActor
    func presentInvalidInputAlert() {
        onboardingAlert = .init(
            title: field.alertTitle,
            message: field.alertDescription
        )
    }
}
