//
//  PostTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation
import Combine

final class PostTagsViewModel: UserInputViewModel {
    typealias Field = PostTagsValidator
    
    @Published var isShowingProgress: Bool = false
    @Published var text: String = ""
    @Published var textErrors: [Field.Requirement] = []
    @Published var alertModel: NewAlertModel?
    @Published var selectableTags: [SelectableTag] = Community.preview.tags.map { SelectableTag(tag: $0) }
    
    private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
}

// MARK: - Methods
extension PostTagsViewModel {
    
    @MainActor
    func submit() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        
        //submitPostInput.title = text
        //coordinator?.didSubmitTitle(input: submitPostInput)
    }
    
    func toggleTag(_ tag: SelectableTag) {
        guard let index = selectableTags.firstIndex(where: { $0.id == tag.id }) else { return }
        selectableTags[index] = SelectableTag(tag: tag.tag, isSelected: !tag.isSelected)
    }
    
    func close() {
        coordinator?.close()
    }
    
    func goBack() {
        coordinator?.goBack()
    }
}
