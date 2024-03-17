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
}

extension SubmittableTextInputViewModel {
    
    var canPerformNextAction: Bool {
        Requirement.getInputValidationErrors(input: text).isEmpty
    }
    
    var fieldTitle: String {
        Requirement.fieldTitle
    }
}
