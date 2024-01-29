//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@Observable final class PostTitleViewModel: FlowViewModel<SubmitPostCoordinator>, UserTextInputViewModel {
    typealias Requirement = DefaultRequirement
    
    @ObservationIgnored private let submitPostInput = SubmitPostInput()
    let flowCase = SubmitPostFlow.title
    let skipAction: (() -> Void)? = nil
    let fieldTitle: String = "Post Title"
    
    override var leadingButtons: [OnboardingTopButton] {
        []
    }
}

// MARK: - Methods
extension PostTitleViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitPostInput.title = text
        coordinator?.didSubmitTitle(input: submitPostInput)
    }
    
    func onAppear() {
        text = submitPostInput.title ?? ""
    }
}
