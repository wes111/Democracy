//
//  AcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Factory
import Foundation

final class AcceptTermsViewModel: ObservableObject, Hashable {
    
    @Published var onboardingAlert: OnboardingAlert?
    private weak var coordinator: OnboardingCoordinatorDelegate?
    private var onboardingInput: OnboardingInput
    @Injected(\.accountService) private var accountService
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [.back: goBack, .close: close]
    }
    
    @MainActor
    func agreeToTerms() async {
        do {
            try await accountService.acceptTerms(input: onboardingInput)
            coordinator?.agreeToTerms(username: onboardingInput.username ?? "") // TODO: Should show error is username is nil.
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
