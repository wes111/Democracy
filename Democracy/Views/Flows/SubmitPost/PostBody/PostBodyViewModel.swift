//
//  PostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@Observable
final class PostBodyViewModel: FlowViewModel<SubmitPostCoordinator>, UserTextEditorInputViewModel {
    var selectedTab: PostBodyTab = .editor
    
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    let skipAction: (() -> Void)? = nil // Not skippable.
    let field = SubmitPostField.body
    let flowCase = SubmitPostFlow.body
    
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
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        submitPostInput.body = text
        coordinator?.didSubmitBody(input: submitPostInput)
    }
    
    func onAppear() {
        text = submitPostInput.body ?? ""
    }
}
