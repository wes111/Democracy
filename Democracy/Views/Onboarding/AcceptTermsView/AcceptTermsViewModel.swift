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
    @Injected(\.onboardingFlowService) private var onboardingManager
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [.back : goBack, .close : close]
    }
    
    func agreeToTerms() {
        Task {
            do {
                try await onboardingManager.acceptTerms()
                coordinator?.agreeToTerms()
            } catch {
                print(error)
                presentAlert()
            }
        }
    }
    
    private func presentAlert() {
        Task {
            await MainActor.run {
                self.onboardingAlert = .init(
                    title: "Create Account Failed",
                    message: "Please try again later."
                )
            }
        }
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
