//
//  EmailInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

final class EmailInputViewModel: UserTextInputViewModel {
    typealias Field = EmailValidator
    
    @Injected(\.accountService) private var accountService
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: NewAlertModel?
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
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
    }
    
    @MainActor
    func presentEmailUnavailableAlert() {
        alertModel = OnboardingAlert.emailUnavailable.toNewAlertModel()
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
