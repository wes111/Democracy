//
//  PostLinkViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

final class PostLinkViewModel: UserTextInputViewModel {
    typealias Field = PostLinkValidator
    
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: NewAlertModel?
    
    private let submitPostInput: SubmitPostInput
    weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
}

// MARK: - Methods
extension PostLinkViewModel {
    
    @MainActor
    func submit() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        submitPostInput.link = text
        coordinator?.didSubmitLink(input: submitPostInput)
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
