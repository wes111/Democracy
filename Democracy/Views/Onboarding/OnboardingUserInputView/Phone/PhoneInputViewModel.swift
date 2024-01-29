//
//  PhoneInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@Observable
final class PhoneInputViewModel: UserTextInputViewModel {
    typealias Requirement = PhoneRequirement
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    
    @ObservationIgnored @Injected(\.accountService) private var accountService
    @ObservationIgnored private var onboardingInput: OnboardingInput
    
    let flowCase = CreateAccountFlow.phone
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
    }
}

// MARK: - Computed Properties
extension PhoneInputViewModel {
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    @MainActor
    var skipAction: (() -> Void)? {
        { self.coordinator?.submitPhone(input: self.onboardingInput) }
    }
}

// MARK: - Methods
extension PhoneInputViewModel {
    
    @MainActor
    func nextButtonAction() async {
        do {
            guard Requirement.fullyValid(input: text) else {
                return alertModel = Requirement.invalidAlert
            }
            guard let phoneBaseInt = Int(PhoneFormatter.format(with: "XXXXXXXXXX", phone: text)) else {
                return // TODO: Throw an error?
            }
            let phoneNumber = PhoneNumber(base: phoneBaseInt)
            guard try await accountService.getPhoneIsAvailable(phoneNumber) else {
                return presentPhoneUnavailableAlert()
            }
            onboardingInput.phone = text
            coordinator?.submitPhone(input: onboardingInput)
        } catch {
            print(error.localizedDescription)
            presentGenericAlert()
        }
    }
    
    @MainActor
    func presentPhoneUnavailableAlert() {
        alertModel = OnboardingAlert.phoneUnavailable.toNewAlertModel()
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
