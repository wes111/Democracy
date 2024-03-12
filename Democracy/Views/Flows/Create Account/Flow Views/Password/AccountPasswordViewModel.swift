//
//  PasswordInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@Observable
final class AccountPasswordViewModel: SubmittableTextInputViewModel {
    typealias Requirement = PasswordRequirement
    typealias FocusedField = AccountFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Create Password"
    private let createAccountInput: CreateAccountInput
    private weak var flowCoordinator: CreateAccountFlowCoordinator?
    @ObservationIgnored @Injected(\.accountService) private var accountService
    
    init(createAccountInput: CreateAccountInput, flowCoordinator: CreateAccountFlowCoordinator?) {
        self.createAccountInput = createAccountInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension AccountPasswordViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        createAccountInput.password = text
        flowCoordinator?.didSubmit(flow: .password)
    }
    
    func onAppear() {
        text = createAccountInput.password ?? ""
    }
}
