//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

final class PostTitleViewModel: UserTextInputViewModel {
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Requirement] = []
    @Published var alertModel: NewAlertModel?
    
    typealias Requirement = NoneRequirement
    let field = SubmitPostField.title
    private let submitPostInput = SubmitPostInput()
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: SubmitPostCoordinatorDelegate?) {
        self.coordinator = coordinator
        
        setupBindings()
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
    
    func setupBindings() {
        $text
            .compactMap { [weak self] text in
                guard !text.isEmpty else { return [] }
                return self?.field.getInputValidationErrors(input: text)
            }
            .assign(to: &$textErrors)
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
