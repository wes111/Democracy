//
//  CommunityLeadersViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityResourcesViewModel: FlowViewModel<CreateCommunityCoordinator>, InputFlowViewModel {
    
    var resources: [Resource] = []
    var isShowingAddResourceSheet = false
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.resources
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension CommunityResourcesViewModel {
    @MainActor
    var skipAction: (() -> Void)? {
        skip
    }
    
    var canPerformNextAction: Bool {
        false // TODO: ...
    }
}

// MARK: - Methods
extension CommunityResourcesViewModel {
    
    @MainActor
    func nextButtonAction() async {
        userInput.resources = resources
        coordinator?.didSubmitSettings(input: userInput)
    }
    
    func onAppear() {
        resources = userInput.resources
    }
    
    // Add resource.
    @MainActor
    func submit() {
        return // TODO: ...
    }
}

// MARK: - Private Methods
private extension CommunityResourcesViewModel {
    
    @MainActor
    func skip() {
        userInput.resources = []
        coordinator?.didSubmitResources(input: userInput)
    }
}
