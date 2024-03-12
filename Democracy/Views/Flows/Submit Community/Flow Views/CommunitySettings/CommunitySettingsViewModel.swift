//
//  CommunitySettingsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunitySettingsViewModel: SubmittableNextButtonViewModel {
    var settings: CommunitySettings
    var selectedSetting: CommunitySetting?
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        settings = submitCommunityInput.settings
        self.flowCoordinator = flowCoordinator
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
        submitCommunityInput.settings = settings
        flowCoordinator?.didSubmit(flow: .settings)
    }
    
    func onAppear() {
        settings = submitCommunityInput.settings
    }
}
