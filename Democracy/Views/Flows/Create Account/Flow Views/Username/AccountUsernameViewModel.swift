//
//  UsernameInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@MainActor @Observable
final class AccountUsernameViewModel: SubmittableTextInputViewModel {
    typealias Requirement = UsernameRequirement
    typealias FocusedField = AccountFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Create Username"
    let field: AccountFlow.ID = .username
    private let createAccountInput: CreateAccountInput
    private weak var flowCoordinator: CreateAccountFlowCoordinator?
    @ObservationIgnored @Injected(\.accountService) var accountService
    
    init(createAccountInput: CreateAccountInput, flowCoordinator: CreateAccountFlowCoordinator?) {
        self.createAccountInput = createAccountInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension AccountUsernameViewModel {
    
    func nextButtonAction() async {
        do {
            guard Requirement.fullyValid(input: text) else {
                return alertModel = Requirement.invalidAlert
            }
            guard try await accountService.getUsernameAvailable(username: text) else {
                return presentUsernameUnavailableAlert()
            }
            createAccountInput.username = text
            try? await Task.sleep(nanoseconds: 150_000)
            flowCoordinator?.didSubmit(flow: .username)
        } catch {
            print(error.localizedDescription)
            alertModel = NewAlertModel.genericAlert
        }
    }
    
    func presentUsernameUnavailableAlert() {
        alertModel = CreateAccountAlert.usernameUnavailable.toNewAlertModel()
    }
    
    func onAppear() {
        text = createAccountInput.username ?? ""
    }
}
