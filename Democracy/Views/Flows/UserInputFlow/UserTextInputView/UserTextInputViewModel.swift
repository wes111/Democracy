//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

protocol UserTextInputViewModel: InputFlowViewModel {
    associatedtype Requirement: InputRequirement
    
    var text: String { get set }
    // var requirement: Requirement { get }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
    
    @MainActor func close()
    @MainActor func goBack()
    @MainActor func presentGenericAlert()
}

extension UserTextInputViewModel {
    
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
