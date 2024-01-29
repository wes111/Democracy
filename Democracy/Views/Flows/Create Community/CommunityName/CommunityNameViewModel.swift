//
//  CommunityNameViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityNameViewModel: FlowViewModel<CreateCommunityCoordinator>, UserTextInputViewModel {
    typealias Requirement = DefaultRequirement
    
    @ObservationIgnored private let userInput = CreateCommunityInput()
    let flowCase = CreateCommunityFlow.name
    let skipAction: (() -> Void)? = nil
    let fieldTitle: String = "Community Name"
    
    override var leadingButtons: [OnboardingTopButton] {
        []
    }
}

// MARK: - Methods
extension CommunityNameViewModel {
    
    @MainActor
    func nextButtonAction() async {
        guard Requirement.fullyValid(input: text) else {
            return alertModel = Requirement.invalidAlert
        }
        userInput.name = text
        coordinator?.didSubmitName(input: userInput)
    }
    
    func onAppear() {
        text = userInput.name ?? ""
    }
}
