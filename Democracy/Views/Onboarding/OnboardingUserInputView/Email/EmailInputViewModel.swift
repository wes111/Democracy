//
//  EmailInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class EmailInputViewModel: InputViewModel {
    typealias Field = EmailValidator
    @Injected(\.accountService) private var accountService
    private var onboardingInput: OnboardingInput
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    @Published var text: String = ""
    @Published var textErrors: [Field.Error] = []
    @Published var onboardingAlert: OnboardingAlert?
    @Published var isShowingProgress: Bool = false
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
        setupBindings()
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [.close: close, .back: goBack]
    }
    
    @MainActor
    func submit() async {
        do {
            guard field.fullyValid(input: text) else {
                return presentInvalidInputAlert()
            }
            guard try await accountService.getEmailAvailable(text) else {
                return presentEmailUnavailableAlert()
            }
            onboardingInput.email = text
            coordinator?.submitEmail(input: onboardingInput)
        } catch {
            print(error.localizedDescription)
            presentGenericAlert()
        }
    }
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    @MainActor
    func presentEmailUnavailableAlert() {
        onboardingAlert = .init(
            title: "Email Unavailable",
            message: "Please enter a different email to continue."
        )
    }
}
