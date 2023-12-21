//
//  AcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Factory
import Foundation

final class AcceptTermsViewModel: ObservableObject, Hashable {
    
    @Injected(\.accountService) private var accountService
    @Published var onboardingAlert: AlertModel?
    @Published var isShowingProgress = false
    
    private weak var coordinator: OnboardingCoordinatorDelegate?
    private var onboardingInput: OnboardingInput
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
    }
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
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
        onboardingAlert = .init(
            title: "Create Account Failed",
            message: "Please try again later."
        )
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
