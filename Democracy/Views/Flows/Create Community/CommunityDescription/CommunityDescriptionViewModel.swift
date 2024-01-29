//
//  CommunityDescriptionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityDescriptionViewModel: FlowViewModel<CreateCommunityCoordinator>, UserTextEditorInputViewModel {
    typealias Requirement = DefaultRequirement
    
    var selectedTab: PostBodyTab = .editor
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let skipAction: (() -> Void)? = nil // Not skippable.
    let flowCase = CreateCommunityFlow.description
    let fieldTitle: String = "Description"
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension CommunityDescriptionViewModel {
    
    var markdown: AttributedString {
        text.toAttributedString()
    }
}

// MARK: - Methods
extension CommunityDescriptionViewModel {
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        userInput.description = text
        coordinator?.didSubmitDescription(input: userInput)
    }
    
    func onAppear() {
        text = userInput.description ?? ""
    }
}
