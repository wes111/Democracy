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
final class PostTagsViewModel: PostViewModel, UserInputViewModel {
    var tags: [String] = Community.preview.tags // TODO: ...
    var selectedTags: Set<String> = []
    
    @ObservationIgnored @Injected(\.postService) private var postService
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    let title = "Add Tags"
    let subtitle = "Add community tags to your post to improve searchability."
    let skipAction: (() -> Void)? = nil
    let flowCase = SubmitPostFlow.tags
    
    init(coordinator: SubmitPostCoordinatorDelegate, submitPostInput: SubmitPostInput
    ) {
        self.submitPostInput = submitPostInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension PostTagsViewModel {
    var canSubmit: Bool {
        !selectedTags.isEmpty
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
    
    func onAppear() {
        selectedTags = submitPostInput.tags
    }
}
