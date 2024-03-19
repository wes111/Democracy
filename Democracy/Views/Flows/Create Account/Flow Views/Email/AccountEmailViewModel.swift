//
//  EmailInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@MainActor @Observable
final class AccountEmailViewModel: SubmittableTextInputViewModel {
    typealias Requirement = EmailRequirement
    typealias FocusedField = AccountFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Add Email"
    let field: AccountFlow.ID = .email
    private let createAccountInput: CreateAccountInput
    private weak var flowCoordinator: CreateAccountFlowCoordinator?
    @ObservationIgnored @Injected(\.accountService) private var accountService
    
    init(createAccountInput: CreateAccountInput, flowCoordinator: CreateAccountFlowCoordinator?) {
        self.createAccountInput = createAccountInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension AccountEmailViewModel {
    
    func nextButtonAction() async {
        do {
            guard Requirement.fullyValid(input: text) else {
                return alertModel = Requirement.invalidAlert
            }
            guard try await accountService.getEmailAvailable(text) else {
                return presentEmailUnavailableAlert()
            }
            createAccountInput.email = text
            try? await Task.sleep(nanoseconds: 150_000)
            flowCoordinator?.didSubmit(flow: .email)
        } catch {
            print(error.localizedDescription)
            alertModel = NewAlertModel.genericAlert
        }
    }
    
    @MainActor
    func presentEmailUnavailableAlert() {
        alertModel = CreateAccountAlert.emailUnavailable.toNewAlertModel()
    }
    
    func onAppear() {
        text = createAccountInput.email ?? ""
    }
}
