//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation

final class PostTitleViewModel: UserTextInputViewModel {
    typealias Field = PostTitleValidator
    
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: NewAlertModel?
    
    private let submitPostInput = SubmitPostInput()
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(coordinator: SubmitPostCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        []
    }()
}

// MARK: - Methods
extension PostTitleViewModel {
    
    @MainActor
    func submit() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        submitPostInput.title = text
        coordinator?.didSubmitTitle(input: submitPostInput)
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
