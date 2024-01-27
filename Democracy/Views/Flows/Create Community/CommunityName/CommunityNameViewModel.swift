//
//  CommunityNameViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityNameViewModel: FlowViewModel<CreateCommunityCoordinator>, UserTextInputViewModel {
    @ObservationIgnored private let userInput = CreateCommunityInput()
    let field = CreateCommunityField.name
    let flowCase = CreateCommunityFlow.name
    let skipAction: (() -> Void)? = nil
    
    override var leadingButtons: [OnboardingTopButton] {
        []
    }
}

// MARK: - Methods
extension CommunityNameViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard field.fullyValid(input: text) else {
            return presentInvalidInputAlert()
        }
        userInput.name = text
        coordinator?.didSubmitName(input: userInput)
    }
    
    func onAppear() {
        text = userInput.name ?? ""
    }
}
