//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation
import Observation

@Observable final class PostTitleViewModel: UserTextInputViewModel {
    typealias Requirement = NoneRequirement
    
    var isShowingProgress: Bool = false
    var text: String = ""
    var textErrors: [Requirement] = []
    var alertModel: NewAlertModel?
    
    @ObservationIgnored let field = SubmitPostField.title
    private let submitPostInput = SubmitPostInput()
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: SubmitPostCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
}

// MARK: - Computed Properties
extension PostTitleViewModel {
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
    
    var leadingButtons: [OnboardingTopButton] {
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
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    @MainActor
    func goBack() {
        coordinator?.goBack()
    }
    
    func onAppear() {
        text = submitPostInput.title ?? ""
    }
}
