//
//  CreatePostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@Observable
final class PostTitleViewModel: SubmittableTextInputViewModel {
    
    typealias Requirement = DefaultRequirement
    typealias FocusedField = PostFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Post Title"
    private let submitPostInput: SubmitPostInput
    private weak var flowCoordinator: SubmitPostFlowCoordinator?
    
    init(input: SubmitPostInput, flowCoordinator: SubmitPostFlowCoordinator) {
        self.submitPostInput = input
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension PostTitleViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitPostInput.title = text
        flowCoordinator?.didSubmit(flow: .title)
    }
    
    func onAppear() {
        text = submitPostInput.title ?? ""
    }
}
