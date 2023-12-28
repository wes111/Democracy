//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

// TODO: The use of a single protocol here exposes too much to the view.
protocol InputViewModel: Hashable, ObservableObject {
    associatedtype Field: InputValidator
    
    var isShowingProgress: Bool { get set }
    var text: String { get set }
    var field: Field.FieldCollection { get }
    var trailingButtons: [OnboardingTopButton] { get }
    var leadingButtons: [OnboardingTopButton] { get }
    var alertModel: NewAlertModel? { get set }
    var title: String { get }
    var subtitle: String { get }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
    var textErrors: [Field.Requirement] { get }
    var canSubmit: Bool { get }
    var allErrors: [Field.Requirement] { get }
    
    func submit() async
    func close()
    func goBack()
    func skip()
    @MainActor func presentGenericAlert()
    @MainActor func presentInvalidInputAlert()
}

extension InputViewModel {
    
    var allErrors: [Field.Requirement] {
        Field.Requirement.allCases as! [Field.Requirement]
    }
    
    var field: Field.FieldCollection {
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
    
    func skip() {
        return // Must override if skippable.
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
