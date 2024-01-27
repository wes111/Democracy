//
//  CommunityDescriptionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityDescriptionViewModel: FlowViewModel<CreateCommunityCoordinator>, UserTextEditorInputViewModel {
    var selectedTab: PostBodyTab = .editor
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let skipAction: (() -> Void)? = nil // Not skippable.
    let field = CreateCommunityField.description
    let flowCase = CreateCommunityFlow.description
    
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
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        userInput.description = text
        coordinator?.didSubmitDescription(input: userInput)
    }
    
    func onAppear() {
        text = userInput.description ?? ""
    }
}
