//
//  UsernameInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@Observable
final class UsernameInputViewModel: UserTextInputViewModel {
    typealias Requirement = UsernameRequirement
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    
    @ObservationIgnored @Injected(\.accountService) private var accountService
    @ObservationIgnored private var onboardingInput = OnboardingInput()
    
    let flowCase = CreateAccountFlow.username
    private weak var coordinator: OnboardingCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: OnboardingCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
}

// MARK: - Computed Properties
extension UsernameInputViewModel {
    var leadingButtons: [OnboardingTopButton] {
        []
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
}

// MARK: - Methods
extension UsernameInputViewModel {
    
    @MainActor
    func nextButtonAction() async {
        do {
            guard Requirement.fullyValid(input: text) else {
                return alertModel = Requirement.invalidAlert
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
    
    @MainActor
    func presentUsernameUnavailableAlert() {
        alertModel = OnboardingAlert.usernameUnavailable.toNewAlertModel()
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
