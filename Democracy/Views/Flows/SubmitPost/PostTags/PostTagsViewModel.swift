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
final class PostTagsViewModel: FlowViewModel<SubmitPostCoordinator>, InputFlowViewModel {
    var tags: [String] = Community.preview.tags // TODO: ...
    var selectedTags: Set<String> = []
    
    @ObservationIgnored @Injected(\.postService) private var postService
    @ObservationIgnored private let submitPostInput: SubmitPostInput
    let skipAction: (() -> Void)? = nil
    let flowCase = SubmitPostFlow.tags
    
    init(coordinator: SubmitPostCoordinator, submitPostInput: SubmitPostInput
    ) {
        self.submitPostInput = submitPostInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension PostTagsViewModel {
    var canPerformNextAction: Bool {
        !selectedTags.isEmpty
    }
}

// MARK: - Methods
extension PostTagsViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard canSubmit else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        do {
            submitPostInput.tags = selectedTags
            try await postService.submitPost(userInput: submitPostInput, communityId: "123") // TODO: ...
            coordinator?.didSubmitTags(input: submitPostInput)
        } catch {
            print(error.localizedDescription)
            alertModel = SubmitPostAlert.createPostFailed.toNewAlertModel()
        }
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
