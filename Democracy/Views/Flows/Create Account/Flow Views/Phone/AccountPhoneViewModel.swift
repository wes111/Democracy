//
//  PhoneInputViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 11/26/23.
//

import Factory
import Foundation

@MainActor @Observable
final class AccountPhoneViewModel: SubmittableTextInputViewModel, SubmittableSkipableViewModel {
    typealias Requirement = PhoneRequirement
    typealias FocusedField = AccountFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Add Phone"
    let field: AccountFlow.ID = .phone
    private let createAccountInput: CreateAccountInput
    private weak var flowCoordinator: CreateAccountFlowCoordinator?
    @ObservationIgnored @Injected(\.accountService) private var accountService
    
    init(createAccountInput: CreateAccountInput, flowCoordinator: CreateAccountFlowCoordinator?) {
        self.createAccountInput = createAccountInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Computed Properties
extension AccountPhoneViewModel {
    
    var skipAction: (() -> Void) {
        { self.flowCoordinator?.didSubmit(flow: .phone) }
    }
}

// MARK: - Methods
extension AccountPhoneViewModel {
    
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
            createAccountInput.phone = text
            try? await Task.sleep(nanoseconds: 150_000)
            flowCoordinator?.didSubmit(flow: .phone)
        } catch {
            print(error.localizedDescription)
            alertModel = NewAlertModel.genericAlert
        }
    }
    
    func presentPhoneUnavailableAlert() {
        alertModel = CreateAccountAlert.phoneUnavailable.toNewAlertModel()
    }
    
    func onAppear() {
        text = createAccountInput.phone ?? ""
    }
}
