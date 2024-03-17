//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@MainActor @Observable
final class PostTitleViewModel: SubmittableTextInputViewModel {
    
    typealias Requirement = DefaultRequirement
    typealias FocusedField = PostFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Post Title"
    let field: PostFlow.ID = .title
    private let submitPostInput: SubmitPostInput
    private weak var flowCoordinator: SubmitPostFlowCoordinator?
    
    init(input: SubmitPostInput, flowCoordinator: SubmitPostFlowCoordinator) {
        self.submitPostInput = input
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension PostTitleViewModel {
    
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitPostInput.title = text
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .title)
    }
    
    func onAppear() {
        text = submitPostInput.title ?? ""
    }
}
