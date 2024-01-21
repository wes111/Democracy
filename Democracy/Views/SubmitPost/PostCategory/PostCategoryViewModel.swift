//
//  PostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

@Observable
final class PostCategoryViewModel: UserInputViewModel {
    var isShowingProgress: Bool = false
    var alertModel: NewAlertModel?
    var selectedCategory: String?
    
    let categories: [String] = Community.preview.categories
    let title = "Select a Category"
    let subtitle = "Each post belongs to a single category within a Community."
    private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    let skipAction: (() -> Void)? = nil
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
}

// MARK: - Computed Properties
extension PostCategoryViewModel {
    var canSubmit: Bool {
        selectedCategory != nil
    }
    
    var leadingButtons: [OnboardingTopButton] {
        [.back]
    }
    
    var trailingButtons: [OnboardingTopButton] {
        [.close(close)]
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
    
    @MainActor
    func close() {
        coordinator?.close()
    }
    
    func onAppear() {
        selectedCategory = submitPostInput.category
    }
}
