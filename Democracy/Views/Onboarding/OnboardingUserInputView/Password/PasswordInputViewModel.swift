//
//  PasswordInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class PasswordInputViewModel: UserTextInputViewModel {
    @Injected(\.accountService) private var accountService
    @Published var text: String = ""
    @Published var textErrors: [Requirement] = []
    @Published var alertModel: NewAlertModel?
    @Published var isShowingProgress: Bool = false
    
    typealias Requirement = PasswordRequirement
    private var onboardingInput: OnboardingInput
    private weak var coordinator: OnboardingCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil
    let field = OnboardingInputField.password
    
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
}

// MARK: - Methods
extension PasswordInputViewModel {
    
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
