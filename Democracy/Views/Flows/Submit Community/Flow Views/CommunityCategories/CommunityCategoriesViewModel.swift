//
//  CommunityCategoriesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor @Observable
final class CommunityCategoriesViewModel: SubmittableMultiTextInputViewModel {
    typealias Requirement = DefaultRequirement
    typealias FocusedField = CommunityFlow.ID
    
    var text: String = ""
    var categories: [String] = []
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Category"
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension CommunityCategoriesViewModel {
    
    var canSubmit: Bool {
        !text.isEmpty && !categories.contains(text)
    }
    
    var canPerformNextAction: Bool {
        !categories.isEmpty
    }
    
    func nextButtonAction() async {
        guard !categories.isEmpty else {
            return presentMissingCategoryAlert()
        }
        submitCommunityInput.categories = Set(categories)
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .categories)
    }
    
    // Add category.
    func submit() {
        guard !categories.contains(text) else {
            return presentCategoryAlreadyAddedAlert()
        }
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        categories.insert(text, at: 0)
        text = ""
    }
    
    func removeCategory(_ category: String) {
        guard let index = categories.firstIndex(of: category) else {
            return
        }
        categories.remove(at: index)
    }
    
    func onAppear() {
        categories = Array(submitCommunityInput.categories)
    }
    
    private func presentMissingCategoryAlert() {
        alertModel = CreateCommunityAlert.missingCategory.toNewAlertModel()
    }
    
    private func presentCategoryAlreadyAddedAlert() {
        alertModel = CreateCommunityAlert.categoryAlreadyAdded.toNewAlertModel()
    }
}
