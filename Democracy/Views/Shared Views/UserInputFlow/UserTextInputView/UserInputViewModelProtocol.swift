//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

// TODO: The use of a single protocol here exposes too much to the view.
protocol UserTextInputViewModel: UserInputViewModel {
    associatedtype Requirement: InputRequirement
    associatedtype Field: InputField
    
    var text: String { get set }
    var field: Field { get }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
    var textErrors: [Requirement] { get }
    
    func close()
    func goBack()
    @MainActor func presentGenericAlert()
    @MainActor func presentInvalidInputAlert()
}

extension UserTextInputViewModel {
    
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
    
    @MainActor
    func presentGenericAlert() {
        alertModel = NewAlertModel.genericAlert
    }
    
    @MainActor
    func presentInvalidInputAlert() {
        alertModel = field.alert.toNewAlertModel()
    }
}
