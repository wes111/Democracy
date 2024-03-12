//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

protocol SubmittableMultiTextInputViewModel: SubmittableTextInputViewModel {
    var canSubmit: Bool { get }
    func submit() async
}

protocol SubmittableTextInputViewModel: SubmittableNextButtonViewModel {
    associatedtype Requirement: InputRequirement
    associatedtype FocusedField: Hashable
    
    var text: String { get set }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
    var alertModel: NewAlertModel? { get set }
    
    @MainActor func presentGenericAlert()
}

extension SubmittableTextInputViewModel {
    
    var maxCharacterCount: Int {
        Requirement.maxCharacterCount
    }
    
    var canPerformNextAction: Bool {
        Requirement.getInputValidationErrors(input: text).isEmpty
    }
    
    @MainActor
    func presentGenericAlert() {
        alertModel = NewAlertModel.genericAlert
    }
    
    var fieldTitle: String {
        Requirement.fieldTitle
    }
}
