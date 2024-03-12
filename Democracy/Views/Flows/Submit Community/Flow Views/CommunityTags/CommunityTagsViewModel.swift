//
//  CommunityTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityTagsViewModel: SubmittableMultiTextInputViewModel {
    typealias Requirement = DefaultRequirement
    typealias FocusedField = CommunityFlow.ID
    
    var text: String = ""
    var tags: [String] = []
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Community Tags"
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension CommunityTagsViewModel {
    
    var canSubmit: Bool {
        !text.isEmpty && !tags.contains(text)
    }
    
    var canPerformNextAction: Bool {
        !tags.isEmpty
    }
    
    @MainActor
    func nextButtonAction() async {
        guard !tags.isEmpty else {
            return presentMissingTagAlert()
        }
        submitCommunityInput.tags = Set(tags)
        flowCoordinator?.didSubmit(flow: .tags)
    }
    
    @MainActor
    func submit() {
        guard !tags.contains(text) else {
            return presentTagAlreadyAddedAlert()
        }
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        tags.insert(text, at: 0)
        text = ""
    }
    
    func removeTag(_ tag: String) {
        guard let index = tags.firstIndex(of: tag) else {
            return
        }
        tags.remove(at: index)
    }
    
    func onAppear() {
        tags = Array(submitCommunityInput.tags)
    }
    
    @MainActor
    private func presentMissingTagAlert() {
        alertModel = CreateCommunityAlert.missingTag.toNewAlertModel()
    }
    
    @MainActor
    private func presentTagAlreadyAddedAlert() {
        alertModel = CreateCommunityAlert.tagAlreadyAdded.toNewAlertModel()
    }
}
