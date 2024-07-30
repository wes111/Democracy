//
//  PostTagsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Factory
import Foundation
import Combine

@MainActor @Observable
final class PostTagsViewModel: SubmittableNextButtonViewModel {
    let tags: [CommunityTag]
    var selectedTags: [CommunityTag] = []
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    private let submitPostInput: SubmitPostInput
    private weak var flowCoordinator: SubmitPostFlowCoordinator?
    
    @ObservationIgnored @Injected(\.postService) private var postService
    
    init(submitPostInput: SubmitPostInput, flowCoordinator: SubmitPostFlowCoordinator?) {
        self.submitPostInput = submitPostInput
        self.flowCoordinator = flowCoordinator
        self.tags = submitPostInput.community.tags
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
    
    func nextButtonAction() async {
        guard canPerformNextAction else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        do {
            submitPostInput.tags = selectedTags
            try await postService.submitPost(userInput: submitPostInput, communityId: submitPostInput.community.id)
            try? await Task.sleep(nanoseconds: 150_000)
            flowCoordinator?.didSubmit(flow: .tags)
        } catch {
            print(error.localizedDescription)
            alertModel = SubmitPostAlert.createPostFailed.toNewAlertModel()
        }
    }
    
    func toggleTag(_ tag: CommunityTag) {
        if selectedTags.contains(tag) {
            selectedTags.removeAll(where: { $0 == tag })
        } else {
            selectedTags.append(tag)
        }
    }
    
    func onAppear() {
        selectedTags = submitPostInput.tags
    }
}
