//
//  CommunityTaglineViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 4/13/24.
//

import Factory
import Foundation

@MainActor @Observable
final class CommunityTaglineViewModel: SubmittableTextInputViewModel {
    typealias Requirement = DefaultRequirement
    typealias FocusedField = CommunityFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Community Tagline"
    var field: CommunityFlow.ID = .tagline
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    @ObservationIgnored @Injected(\.communityService) private var communityService
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
    }
}

extension CommunityTaglineViewModel {
    func  nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitCommunityInput.tagline = text
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .tagline)
    }
    
    func onAppear() {
        text = submitCommunityInput.tagline ?? ""
    }
}
