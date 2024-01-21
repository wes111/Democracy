//
//  PostTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation
import Combine

@Observable
final class PostTagsViewModel: UserInputViewModel {
    var isShowingProgress: Bool = false
    var alertModel: NewAlertModel?
    var tags: [String] = Community.preview.tags // TODO: ...
    var selectedTags: Set<String> = []
    
    @ObservationIgnored @Injected(\.postService) private var postService
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    
    let title = "Add Tags"
    let subtitle = "Add community tags to your post to improve searchability."
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
}

// MARK: - Computed Properties
extension PostTagsViewModel {
    var canSubmit: Bool {
        !selectedTags.isEmpty
    }
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
    }
}

// MARK: - Methods
extension PostTagsViewModel {
    
    @MainActor
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
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    func onAppear() {
        selectedTags = submitPostInput.tags
    }
}
