//
//  PostTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation
import Combine

final class PostTagsViewModel: UserInputViewModel {
    @Published var isShowingProgress: Bool = false
    @Published var alertModel: NewAlertModel?
    @Published var selectableTags: [SelectableTag] = Community.preview.tags.map { SelectableTag(tag: $0) }
    
    let title = "Add Tags"
    let subtitle = "Add community tags to your post to improve searchability."
    private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
}

// MARK: - Computed Properties
extension PostTagsViewModel {
    var canSubmit: Bool {
        selectableTags.contains { $0.isSelected }
    }
}

// MARK: - Methods
extension PostTagsViewModel {
    
    func submit() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard canSubmit else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        submitPostInput.tags = selectableTags.filter { $0.isSelected }.map { $0.tag }
        coordinator?.didSubmitTags(input: submitPostInput)
    }
    
    func toggleTag(_ tag: SelectableTag) {
        guard let index = selectableTags.firstIndex(where: { $0.id == tag.id }) else { return }
        selectableTags[index] = SelectableTag(tag: tag.tag, isSelected: !tag.isSelected)
    }
    
    func close() {
        coordinator?.close()
    }
}
