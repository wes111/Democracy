//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

@MainActor
protocol SubmittableMultiTextInputViewModel: SubmittableTextInputViewModel {
    var canSubmit: Bool { get }
    func submit() async
}

@MainActor
protocol SubmittableTextInputViewModel: SubmittableNextButtonViewModel {
    associatedtype Requirement: InputRequirement
    associatedtype FocusedField: Hashable
    
    var field: FocusedField { get }
    var text: String { get set }
    var alertModel: NewAlertModel? { get set }
    
    func presentGenericAlert()
}

extension SubmittableTextInputViewModel {
    
    var canPerformNextAction: Bool {
        Requirement.getInputValidationErrors(input: text).isEmpty
    }
    
    func presentGenericAlert() {
        alertModel = NewAlertModel.genericAlert
    }
    
    var fieldTitle: String {
        Requirement.fieldTitle
    }
}
