//
//  PhoneInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class PhoneInputViewModel: InputViewModel {
    typealias Field = PhoneValidator
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
        //try? await Task.sleep(nanoseconds: 1_000_000_000)
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        onboardingInput.phone = text
        coordinator?.submitPhone(input: onboardingInput)
    }
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
}
