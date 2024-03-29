//
//  PostTitleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import Foundation

@MainActor @Observable
final class PostBodyViewModel: SubmittableTextEditorInputViewModel {
    typealias Requirement = DefaultRequirement
    typealias FocusedField = PostFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    var selectedTab: PostBodyTab = .editor
    let fieldTitle: String = "Post Content"
    let field: PostFlow.ID = .body
    private let submitPostInput: SubmitPostInput
    private weak var flowCoordinator: SubmitPostFlowCoordinator?
    
    init(submitPostInput: SubmitPostInput, flowCoordinator: SubmitPostFlowCoordinator?) {
        self.submitPostInput = submitPostInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Computed Properties
extension PostBodyViewModel {
    
    var markdown: AttributedString {
        text.toAttributedString()
    }
}

// MARK: - Methods
extension PostBodyViewModel {
    
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        submitPostInput.body = text
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .body)
    }
    
    func onAppear() {
        text = submitPostInput.body ?? ""
    }
}
