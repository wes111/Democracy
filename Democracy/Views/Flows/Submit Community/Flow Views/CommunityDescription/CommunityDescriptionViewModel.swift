//
//  CommunityDescriptionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor @Observable
final class CommunityDescriptionViewModel: SubmittableTextEditorInputViewModel {
    typealias Requirement = DefaultRequirement
    typealias FocusedField = CommunityFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    var selectedTab: PostBodyTab = .editor
    let fieldTitle: String = "Description"
    let field: CommunityFlow.ID = .description
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Computed Properties
extension CommunityDescriptionViewModel {
    
    var markdown: AttributedString {
        text.toAttributedString()
    }
}

// MARK: - Methods
extension CommunityDescriptionViewModel {
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitCommunityInput.description = text
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .description)
    }
    
    func onAppear() {
        text = submitCommunityInput.description ?? ""
    }
}
