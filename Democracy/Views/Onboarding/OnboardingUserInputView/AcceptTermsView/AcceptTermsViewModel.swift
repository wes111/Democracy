//
//  AcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Factory
import Foundation

@Observable
final class AcceptTermsViewModel: Hashable {
    var onboardingAlert: NewAlertModel?
    var isShowingProgress = false
    
    @ObservationIgnored @Injected(\.accountService) private var accountService
    @ObservationIgnored private weak var coordinator: OnboardingCoordinatorDelegate?
    @ObservationIgnored private var onboardingInput: OnboardingInput
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
    }
}

// MARK: - Computed Properties
extension AcceptTermsViewModel {
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
}

// MARK: - Methods
extension AcceptTermsViewModel {
    
    @MainActor
    func agreeToTerms() async {
        do {
            try await accountService.acceptTerms(input: onboardingInput)
            coordinator?.agreeToTerms(username: onboardingInput.username ?? "")
        } catch {
            print(error)
            presentAlert()
        }
    }
    
    @MainActor
    private func presentAlert() {
        onboardingAlert = OnboardingAlert.createAccountFailed.toNewAlertModel()
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
