//
//  UsernameInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class UsernameInputViewModel: UserTextInputViewModel {
    typealias Field = UsernameValidator
    
    @Injected(\.accountService) private var accountService
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: NewAlertModel?
    @Published var isShowingProgress: Bool = false
    
    private var onboardingInput = OnboardingInput()
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
        setupBindings()
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        []
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
}

// MARK: - Methods
extension UsernameInputViewModel {
    
    @MainActor
    func submit() async {
         try? await Task.sleep(nanoseconds: 1_000_000_000) // TODO: Remove.
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
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    @MainActor
    func presentUsernameUnavailableAlert() {
        alertModel = OnboardingAlert.usernameUnavailable.toNewAlertModel()
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
