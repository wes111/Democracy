//
//  CommunityNameViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityNameViewModel: SubmittableTextInputViewModel {
    typealias Requirement = DefaultRequirement
    typealias FocusedField = CommunityFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Community Name"
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension CommunityNameViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitCommunityInput.name = text
        flowCoordinator?.didSubmit(flow: .name)
    }
    
    func onAppear() {
        text = submitCommunityInput.name ?? ""
    }
}
