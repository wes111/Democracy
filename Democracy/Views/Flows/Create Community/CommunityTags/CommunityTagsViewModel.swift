//
//  CommunityTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityTagsViewModel: FlowViewModel<CreateCommunityCoordinator>, UserTextInputViewModel {
    typealias Requirement = DefaultRequirement
    
    var tags: [String] = []
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.tags
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
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
        userInput.tags = Set(tags)
        coordinator?.didSubmitTags(input: userInput)
    }
    
    // Add tag.
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
        tags = Array(userInput.tags)
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
