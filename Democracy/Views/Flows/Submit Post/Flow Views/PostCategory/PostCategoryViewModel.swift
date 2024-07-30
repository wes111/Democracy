//
//  PostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

@MainActor @Observable
final class PostCategoryViewModel: SubmittableNextButtonViewModel {
    var selectedCategory: String?
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let categories: [PostCategory]
    private let submitPostInput: SubmitPostInput
    private weak var flowCoordinator: SubmitPostFlowCoordinator?
    
    init(submitPostInput: SubmitPostInput, flowCoordinator: SubmitPostFlowCoordinator?) {
        self.submitPostInput = submitPostInput
        self.flowCoordinator = flowCoordinator
        self.categories = submitPostInput.community.categories
    }
}

// MARK: - Computed Properties
extension PostCategoryViewModel {
    var canPerformNextAction: Bool {
        selectedCategory != nil
    }
}

// MARK: - Methods
extension PostCategoryViewModel {
    
    func nextButtonAction() async {
        guard canPerformNextAction else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        submitPostInput.category = selectedCategory
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .category)
    }
    
    func toggleCategory(_ category: String) {
        if selectedCategory == nil || selectedCategory != category {
            selectedCategory = category
        } else {
            selectedCategory = nil
        }
    }
    
    func onAppear() {
        selectedCategory = submitPostInput.category
    }
}
