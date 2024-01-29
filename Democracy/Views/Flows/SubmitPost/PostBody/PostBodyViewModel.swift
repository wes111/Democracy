//
//  PostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@Observable
final class PostBodyViewModel: FlowViewModel<SubmitPostCoordinator>, UserTextEditorInputViewModel {
    typealias Requirement = DefaultRequirement
    
    var selectedTab: PostBodyTab = .editor
    
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    let skipAction: (() -> Void)? = nil // Not skippable.
    let flowCase = SubmitPostFlow.body
    let fieldTitle: String = "Post Content"
    
    init(coordinator: SubmitPostCoordinator, submitPostInput: SubmitPostInput) {
        self.submitPostInput = submitPostInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension PostBodyViewModel {
    
    var markdown: AttributedString {
        text.toAttributedString()
    }
}

// MARK: - Methods
extension PostBodyViewModel {
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitPostInput.body = text
        coordinator?.didSubmitBody(input: submitPostInput)
    }
    
    func onAppear() {
        text = submitPostInput.body ?? ""
    }
}
