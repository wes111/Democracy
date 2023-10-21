//
//  OnboardingUserInputViewModelProtocol.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/14/23.
//

import Factory
import Foundation

protocol OnboardingCoordinatorDelegate: AnyObject {
    func didSubmitUsername()
    func submitPassword()
    func submitEmail()
    func agreeToTerms()
    func continueAccountSetup()
    func submitPhone()
    //func submitPhoneVerification()
    func submitEmailVerification()
    
    func close()
    func goBack()
}

class OnboardingUserInputViewModel<T: ValidatableOnboardingField>: Hashable, ObservableObject {
    
    typealias TopButtonsDictionary = [OnboardingTopButton : () -> Void]
    @Published var text: String = ""
    @Published var textErrors: [T.Error] = []
    @Published var onboardingAlert: OnboardingAlert?
    @Injected(\.onboardingFlowService) private var onboardingManager
    
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
        setupBindings()
    }
}

//MARK: - Computed Properties
extension OnboardingUserInputViewModel {
    
    var topButtons: TopButtonsDictionary {
        switch T.field {
        case .username:
            [.close : close]
        case .password:
            [.close: close, .back : goBack]
        case .email:
            [.close: close, .back : goBack]
        case .phone:
            [.close: close]
//        case .verifyPhone:
//            [.close: close]
        case .verifyEmail:
            [.close: close]
        }
    }
    
    var title: String {
        T.field.title
    }
    
    var subtitle: String {
        T.field.subtitle
    }
    
    var fieldTitle: String {
        T.field.fieldTitle
    }
    
    var maxCharacterCount: Int {
        T.field.maxCharacterCount
    }
    
    var canSubmit: Bool {
        T.field.fullyValid(input: text)
    }
}

//MARK: - Methods
extension OnboardingUserInputViewModel {
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
    
    func submit() async {
        do {
            try await onboardingManager.submit(input: text, field: T.field)
            
            switch T.field {
            case .username:
                coordinator?.didSubmitUsername()
            case .password:
                coordinator?.submitPassword()
            case .email:
                coordinator?.submitEmail()
            case .phone:
                coordinator?.submitPhone()
//            case .verifyPhone:
//                coordinator?.submitPhoneVerification()
            case .verifyEmail:
                coordinator?.submitEmailVerification()
            }
        } catch {
            presentAlert()
        }
    }
    
    func resetTextField() async {
        if let text = onboardingManager.getSubmittedValue(field: T.field) {
            await MainActor.run {
                self.text = text
            }
        }
    }
}

//MARK: - Private methods
extension OnboardingUserInputViewModel {
    func presentAlert() {
        Task {
            await MainActor.run {
                self.onboardingAlert = .init(
                    title: T.field.alertTitle,
                    message: T.field.alertDescription
                )
            }
        }
    }
    
    func setupBindings() {
        $text
            .debounce(for: 0.25, scheduler: RunLoop.main)
            .compactMap { text in
                guard !text.isEmpty else { return [] }
                return T.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
}
