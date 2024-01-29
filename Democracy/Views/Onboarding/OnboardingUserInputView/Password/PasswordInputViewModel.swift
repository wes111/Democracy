//
//  PasswordInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@Observable
final class PasswordInputViewModel: UserTextInputViewModel {
    typealias Requirement = PasswordRequirement
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    
    @ObservationIgnored @Injected(\.accountService) private var accountService
    @ObservationIgnored private var onboardingInput: OnboardingInput
    
    private weak var coordinator: OnboardingCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil // Not skippable.
    let flowCase = CreateAccountFlow.password
    let fieldTitle: String = Requirement.fieldTitle
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
    }
}

extension PasswordInputViewModel {
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
}

// MARK: - Methods
extension PasswordInputViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        onboardingInput.password = text
        coordinator?.submitPassword(input: onboardingInput)
    }
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    @MainActor
    func goBack() {
        coordinator?.goBack()
    }
}
