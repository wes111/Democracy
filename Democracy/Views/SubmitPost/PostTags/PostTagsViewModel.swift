//
//  PostTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation
import Combine

final class PostTagsViewModel: UserInputViewModel {
    @Published var isShowingProgress: Bool = false
    @Published var alertModel: NewAlertModel?
    @Published var tags: [String] = Community.preview.tags // TODO: ...
    @Published var selectedTags: Set<String> = []
    
    @Injected(\.postService) private var postService
    
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
        !selectedTags.isEmpty
    }
}

// MARK: - Methods
extension PostTagsViewModel {
    
    func submit() async {
        guard canSubmit else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        do {
            try await postService.submitPost(userInput: submitPostInput, communityId: "123") // TODO: ...
        } catch {
            print(error.localizedDescription)
            alertModel = SubmitPostAlert.createPostFailed.toNewAlertModel()
        }
        
        submitPostInput.tags = selectedTags
        coordinator?.didSubmitTags(input: submitPostInput)
    }
    
    func toggleTag(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
    
    func close() {
        coordinator?.close()
    }
    
    func onAppear() {
        selectedTags = submitPostInput.tags
    }
}
