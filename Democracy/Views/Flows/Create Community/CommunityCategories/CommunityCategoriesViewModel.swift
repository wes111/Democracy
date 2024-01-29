//
//  CommunityCategoriesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityCategoriesViewModel: FlowViewModel<CreateCommunityCoordinator>, UserTextInputViewModel {
    typealias Requirement = DefaultRequirement
    
    var categories: [String] = []
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.categories
    let skipAction: (() -> Void)? = nil
    let fieldTitle: String = "Category"
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Methods
extension CommunityCategoriesViewModel {
    
    var canSubmit: Bool {
        !categories.isEmpty
    }
    
    @MainActor
    func nextButtonAction() async {
        guard !categories.isEmpty else {
            return presentMissingCategoryAlert()
        }
        userInput.categories = Set(categories)
        coordinator?.didSubmitCategories(input: userInput)
    }
    
    // Add category.
    @MainActor
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
        categories = Array(userInput.categories)
    }
    
    @MainActor
    private func presentMissingCategoryAlert() {
        alertModel = CreateCommunityAlert.missingCategory.toNewAlertModel()
    }
    
    @MainActor
    private func presentCategoryAlreadyAddedAlert() {
        alertModel = CreateCommunityAlert.categoryAlreadyAdded.toNewAlertModel()
    }
}
