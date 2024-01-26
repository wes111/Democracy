//
//  CommunityCategoriesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityCategoriesViewModel: FlowViewModel<CreateCommunityCoordinator>, UserTextInputViewModel {
    var textErrors: [NoneRequirement] = []
    var categories: [String] = []
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let field = CreateCommunityField.categories
    let flowCase = CreateCommunityFlow.categories
    let skipAction: (() -> Void)? = nil
    
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
    func submit() async {
        guard !categories.isEmpty else {
            return presentMissingCategoryAlert()
        }
        userInput.categories = Set(categories)
        coordinator?.didSubmitCategories(input: userInput)
    }
    
    @MainActor
    func addCategory() {
        guard !categories.contains(text) else {
            return presentCategoryAlreadyAddedAlert()
        }
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
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
        text = userInput.name ?? ""
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
