//
//  CommunitySettingsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunitySettingsViewModel: FlowViewModel<CreateCommunityCoordinator>, InputFlowViewModel {
    var settings: CommunitySettings
    var selectedSetting: CommunitySetting?
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.settings
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        settings = userInput.settings
        super.init(coordinator: coordinator)
    }
}

// MARK: Computed Properties
extension CommunitySettingsViewModel {
    
    var canPerformNextAction: Bool {
        true // All fields have default values
    }
}

// MARK: - Methods
extension CommunitySettingsViewModel {
    
    @MainActor
    func nextButtonAction() async {
        userInput.settings = settings
        coordinator?.didSubmitSettings(input: userInput)
    }
    
    func onAppear() {
        settings = userInput.settings
    }
}
