//
//  UsernameInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class UsernameInputViewModel: InputViewModel {
    typealias Field = UsernameValidator
    @Injected(\.accountService) private var accountService
    private var onboardingInput = OnboardingInput()
    weak var coordinator: OnboardingCoordinatorDelegate?
    
    @Published var text: String = ""
    @Published var textErrors: [Field.Error] = []
    @Published var onboardingAlert: OnboardingAlert?
    @Published var isShowingProgress: Bool = false
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
        setupBindings()
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [.close: close]
    }
    
    @MainActor // TODO: Need to test using @MainActor like this.
    func submit() async {
        isShowingProgress = true
        defer {
            isShowingProgress = false
        }
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        do {
            guard field.fullyValid(input: text) else {
                return presentInvalidInputAlert()
            }
            guard try await accountService.getUsernameAvailable(username: text) else {
                return presentUsernameUnavailableAlert()
            }
            onboardingInput.username = text
            coordinator?.didSubmitUsername(input: onboardingInput)
        } catch {
            print(error.localizedDescription)
            presentGenericAlert()
        }
    }
    
    func setupBindings() {
        $text
            .debounce(for: 0.05, scheduler: RunLoop.main)
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    @MainActor
    func presentUsernameUnavailableAlert() {
        onboardingAlert = .init(
            title: "Username unavailable",
            message: "Please enter a different username to continue."
        )
    }
}
