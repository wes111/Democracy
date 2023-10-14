//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Foundation

//For the create fields. Each gets its own vm.
protocol OnboardingUserInputViewModelProtocol: ObservableObject, Hashable {
    associatedtype Error: ValidationError
    associatedtype Field: UserInputField
    typealias TopButtonsDictionary = [OnboardingTopButton : () -> Void]
    
    var field: Field { get }
    var text: String { get set }
    var textErrors: [Error] { get }
    var submitAction: () -> Void { get }
    var topButtons: TopButtonsDictionary { get }
    var title: String { get }
    var subtitle: String { get }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
}

extension OnboardingUserInputViewModelProtocol {
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
}

protocol OnboardingCoordinatorDelegate: AnyObject {
    func submitUsername()
    func submitPassword()
    func submitEmail()
    func agreeToTerms()
    func continueAccountSetup()
    func submitPhone()
    func submitPhoneVerification()
    func submitEmailVerification()
    
    func close()
    func goBack()
}

// Preferably, the logic in this class would be in the OnboardingUserInputViewModelProtocol
// and extension, but since property wrappers are difficult to work with in protocols,
// we keep them in this class instead. Keeping the coordinator in this class allows it
// to remain inaccessible from the view
class OnboardingUserInputViewModel<Field: UserInputField> {
    
    @Published var text: String = ""
    @Published var textErrors: [Field.InputError] = []
    let field = Field()
    
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
        
        setupBindings()
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
    
    private func setupBindings() {
        $text
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
}
