//
//  CreateFieldViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/5/23.
//

import Foundation

enum OnboardingTopButton: CaseIterable {
    case back
    case close
}

//protocol CreateFieldCoordinatorDelegate: AnyObject {
//    func goBack()
//    func close()
//}

//For the create fields. Each gets its own vm.
protocol NewViewModelProtocol: ObservableObject, Hashable {
    associatedtype Error: ValidationError
    associatedtype Field: UserInputField
    typealias SubmitAction = (() -> Void)?
    typealias TopButtonsDictionary = [OnboardingTopButton : () -> Void]
    
    var field: Field { get }
    var text: String { get set }
    var textErrors: [Error] { get }
    var submitAction: SubmitAction { get }
    var topButtons: TopButtonsDictionary { get }
    var title: String { get }
    var subtitle: String { get }
    var fieldTitle: String { get }
    var maxCharacterCount: Int { get }
}

extension NewViewModelProtocol {
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

final class EmailVerificationViewModel: NewViewModelProtocol {
    typealias Field = VerifyEmailField
    
    @Published var text: String = ""
    @Published var textErrors: [VerifyEmailCodeValidationError] = []
    
    var submitAction: SubmitAction {
        coordinator?.submitEmailVerification
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close]
    }
    
    let field = Field()
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    deinit {
        
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

final class PhoneVerificationViewModel: NewViewModelProtocol {
    typealias Field = VerifyPhoneField
    
    @Published var text: String = ""
    @Published var textErrors: [VerifyPhoneCodeValidationError] = []
    
    var submitAction: SubmitAction {
        coordinator?.submitPhoneVerification
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close]
    }
    
    let field = Field()
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    deinit {
        
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

final class CreatePhoneViewModel: NewViewModelProtocol {
    typealias Field = CreatePhoneField
    
    @Published var text: String = ""
    @Published var textErrors: [PhoneValidationError] = []
    
    var submitAction: SubmitAction {
        coordinator?.submitPhone
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close]
    }
    
    let field = Field()
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    deinit {
        
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

final class CreateEmailViewModel: NewViewModelProtocol {
    typealias Field = CreateEmailField
    
    @Published var text: String = ""
    @Published var textErrors: [EmailValidationError] = []
    
    var submitAction: SubmitAction {
        coordinator?.submitEmail
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close, .back : goBack]
    }
    
    let field = Field()
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    deinit {
        
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

final class CreatePasswordViewModel: NewViewModelProtocol {
    typealias Field = CreatePasswordField
    
    @Published var text: String = ""
    @Published var textErrors: [PasswordValidationError] = []
    
    var submitAction: SubmitAction {
        coordinator?.submitPassword
    }
    
    var topButtons: TopButtonsDictionary {
        [.close: close, .back : goBack]
    }
    
    let field = Field()
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    deinit {
        
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

final class CreateUsernameViewModel: NewViewModelProtocol {
    
    typealias Field = CreateUsernameField
    
    @Published var text: String = ""
    @Published var textErrors: [UsernameValidationError] = []
    
    var submitAction: SubmitAction {
        coordinator?.submitUsername
    }
    
    var topButtons: TopButtonsDictionary {
        [.close : close]
    }
    
    let field = Field()
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    deinit {
        print()
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
