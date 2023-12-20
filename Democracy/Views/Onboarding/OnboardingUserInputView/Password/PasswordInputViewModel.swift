//
//  PasswordInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class PasswordInputViewModel: InputViewModel {
    typealias Field = PasswordValidator
    @Injected(\.accountService) private var accountService
    private var onboardingInput: OnboardingInput
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var onboardingAlert: OnboardingAlert?
    @Published var isShowingProgress: Bool = false
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
        setupBindings()
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    @MainActor
    func submit() async {
        // try? await Task.sleep(nanoseconds: 1_000_000_000)
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        onboardingInput.password = text
        coordinator?.submitPassword(input: onboardingInput)
    }
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
