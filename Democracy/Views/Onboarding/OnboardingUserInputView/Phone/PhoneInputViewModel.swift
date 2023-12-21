//
//  PhoneInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class PhoneInputViewModel: InputViewModel {
    typealias Field = PhoneValidator
    
    @Injected(\.accountService) private var accountService
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: AlertModel?
    @Published var isShowingProgress: Bool = false
    
    private var onboardingInput: OnboardingInput
    private weak var coordinator: OnboardingCoordinatorDelegate?
    
    init(coordinator: OnboardingCoordinatorDelegate?, onboardingInput: OnboardingInput) {
        self.coordinator = coordinator
        self.onboardingInput = onboardingInput
        setupBindings()
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
}

// MARK: - Methods
extension PhoneInputViewModel {
    
    func skip() {
        coordinator?.submitPhone(input: onboardingInput)
    }
    
    @MainActor
    func submit() async {
        do {
            guard field.fullyValid(input: text) else {
                return presentInvalidInputAlert()
            }
            guard let phoneBaseInt = Int(PhoneTextFieldStyle.format(with: "XXXXXXXXXX", phone: text)) else {
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
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    @MainActor
    func presentPhoneUnavailableAlert() {
        alertModel = .init(
            title: "Phone Number Unavailable",
            message: "Please enter a different phone number to continue."
        )
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
