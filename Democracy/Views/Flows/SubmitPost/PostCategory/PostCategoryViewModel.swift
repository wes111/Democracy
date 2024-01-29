//
//  PostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

@Observable
final class PostCategoryViewModel: FlowViewModel<SubmitPostCoordinator>, InputFlowViewModel {
    var selectedCategory: String?
    
    let categories: [String] = Community.preview.categories
    private let submitPostInput: SubmitPostInput
    let skipAction: (() -> Void)? = nil
    let flowCase = SubmitPostFlow.category
    
    init(coordinator: SubmitPostCoordinator, submitPostInput: SubmitPostInput
    ) {
        self.submitPostInput = submitPostInput
        super.init(coordinator: coordinator)
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
    @MainActor
    func nextButtonAction() async {
        guard canSubmit else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        submitPostInput.category = selectedCategory
        coordinator?.didSubmitCategory(input: submitPostInput)
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
