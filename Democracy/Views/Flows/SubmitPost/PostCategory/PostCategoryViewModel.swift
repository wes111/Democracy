//
//  PostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

@Observable
final class PostCategoryViewModel: FlowViewModel<SubmitPostCoordinator>, UserInputViewModel {
    var selectedCategory: String?
    
    let categories: [String] = Community.preview.categories
    let title = "Select a Category"
    let subtitle = "Each post belongs to a single category within a Community."
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
    var canSubmit: Bool {
        selectedCategory != nil
    }
}

// MARK: - Methods
extension PostCategoryViewModel {
    @MainActor
    func submit() async {
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
