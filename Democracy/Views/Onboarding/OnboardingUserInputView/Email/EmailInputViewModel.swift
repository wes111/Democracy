//
//  EmailInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@Observable
final class EmailInputViewModel: UserTextInputViewModel {
    typealias Requirement = EmailRequirement
    
    var text: String = ""
    var textErrors: [Requirement] = []
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    
    @ObservationIgnored @Injected(\.accountService) private var accountService
    @ObservationIgnored private var onboardingInput: OnboardingInput
    
    let field = OnboardingInputField.email
    private weak var coordinator: OnboardingCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
    }
}

// MARK: - Computed Properties
extension EmailInputViewModel {
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
}

// MARK: - Methods
extension EmailInputViewModel {
    
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
    
    @MainActor
    func presentEmailUnavailableAlert() {
        alertModel = OnboardingAlert.emailUnavailable.toNewAlertModel()
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
