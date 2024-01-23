//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@Observable final class PostTitleViewModel: PostViewModel, UserTextInputViewModel {
    typealias Requirement = NoneRequirement
    var textErrors: [Requirement] = []
    
    @ObservationIgnored private let submitPostInput = SubmitPostInput()
    let field = SubmitPostField.title
    let flowCase = SubmitPostFlow.title
    let skipAction: (() -> Void)? = nil
    
    override var leadingButtons: [OnboardingTopButton] {
        []
    }
}

// MARK: - Methods
extension PostTitleViewModel {
    
    @MainActor
    func submit() async {
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        submitPostInput.title = text
        coordinator?.didSubmitTitle(input: submitPostInput)
    }
    
    func onAppear() {
        text = submitPostInput.title ?? ""
    }
}
