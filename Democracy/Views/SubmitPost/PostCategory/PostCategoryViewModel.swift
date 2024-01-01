//
//  PostCategoryViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/30/23.
//

import Foundation

final class PostCategoryViewModel: UserInputViewModel {
    @Published var isShowingProgress: Bool = false
    @Published var alertModel: NewAlertModel?
    @Published var selectedCategory: CommunityCategory?
    
    let categories: [CommunityCategory] = Community.preview.postCategories
    let title = "Select a Category"
    let subtitle = "Each post belongs to a single category within a Community."
    private let submitPostInput: SubmitPostInput
    private weak var coordinator: SubmitPostCoordinatorDelegate?
    
    init(
        coordinator: SubmitPostCoordinatorDelegate,
        submitPostInput: SubmitPostInput
    ) {
        self.coordinator = coordinator
        self.submitPostInput = submitPostInput
    }
    
    lazy var leadingButtons: [OnboardingTopButton] = {
        [.back]
    }()
    
    lazy var trailingButtons: [OnboardingTopButton] = {
        [.close(close)]
    }()
}

// MARK: - Computed Properties
extension PostCategoryViewModel {
    var canSubmit: Bool {
        selectedCategory != nil
    }
}

// MARK: - Methods
extension PostCategoryViewModel {
    func submit() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        guard canSubmit else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        submitPostInput.category = selectedCategory
        coordinator?.didSubmitCategory(input: submitPostInput)
    }
    
    func toggleCategory(_ category: CommunityCategory) {
        if selectedCategory == nil || selectedCategory != category {
            selectedCategory = category
        } else {
            selectedCategory = nil
        }
    }
    
    func close() {
        coordinator?.close()
    }
    
    func onAppear() {
        selectedCategory = submitPostInput.category
    }
}
