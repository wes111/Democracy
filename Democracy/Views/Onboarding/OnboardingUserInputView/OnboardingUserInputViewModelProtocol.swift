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
    func close()
    func goBack()
}

class OnboardingUserInputViewModel<T: ValidatableOnboardingField>: Hashable, ObservableObject {
    
    typealias TopButtonsDictionary = [OnboardingTopButton : () -> Void]
    @Published var text: String = ""
    @Published var textErrors: [T.Error] = []
    @Published var onboardingAlert: OnboardingAlert?
    @Published var isLoading: Bool = false
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
        await MainActor.run {
            isLoading = true
        }
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        do {
            switch T.field {
                
            case .username:
                guard try await onboardingManager.usernameIsAvailable(text) else {
                    await MainActor.run {
                        isLoading = false
                    }
                    return presentUsernameUnavailableAlert()
                }
                try await onboardingManager.submit(input: text, field: T.field)
                coordinator?.didSubmitUsername()
                
            case .password:
                try await onboardingManager.submit(input: text, field: T.field)
                coordinator?.submitPassword()
                
            case .email:
                try await onboardingManager.submit(input: text, field: T.field)
                coordinator?.submitEmail()
                
            case .phone:
                try await onboardingManager.submit(input: text, field: T.field)
                coordinator?.submitPhone()
            }
        } catch {
            print(error.localizedDescription)
            await MainActor.run {
                isLoading = false
            }
            if let onboardingError = error as? OnboardingError, onboardingError == .invalidField {
                presentInvalidInputAlert()
            } else {
                presentGenericAlert()
            }
        }
        
        await MainActor.run {
            isLoading = false
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
    func presentInvalidInputAlert() {
        Task {
            await MainActor.run {
                self.onboardingAlert = .init(
                    title: T.field.alertTitle,
                    message: T.field.alertDescription
                )
            }
        }
    }
    
    func presentUsernameUnavailableAlert() {
        Task {
            await MainActor.run {
                self.onboardingAlert = .init(
                    title: "Username unavailable",
                    message: "Please enter a different username to continue."
                )
            }
        }
    }
    
    func presentGenericAlert() {
        Task {
            await MainActor.run {
                self.onboardingAlert = .init(
                    title: "Error",
                    message: "An error occurred, please try again later."
                )
            }
        }
    }
    
    func setupBindings() {
        $text
            .debounce(for: 0.05, scheduler: RunLoop.main)
            .compactMap { text in
                guard !text.isEmpty else { return [] }
                return T.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
}
