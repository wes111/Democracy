//
//  AcceptTermsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/6/23.
//

import Factory
import Foundation

@Observable
final class AccountAcceptTermsViewModel {
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    private let createAccountInput: CreateAccountInput
    private weak var flowCoordinator: CreateAccountFlowCoordinator?
    @ObservationIgnored @Injected(\.accountService) private var accountService
    
    init(createAccountInput: CreateAccountInput, flowCoordinator: CreateAccountFlowCoordinator?) {
        self.createAccountInput = createAccountInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension AccountAcceptTermsViewModel {
    
    @MainActor
    func agreeToTerms() async {
        do {
            try await accountService.acceptTerms(input: createAccountInput)
            flowCoordinator?.didSubmit(flow: .acceptTerms)
        } catch {
            print(error)
            presentAlert()
        }
    }
    
    @MainActor
    private func presentAlert() {
        alertModel = CreateAccountAlert.createAccountFailed.toNewAlertModel()
    }
}
