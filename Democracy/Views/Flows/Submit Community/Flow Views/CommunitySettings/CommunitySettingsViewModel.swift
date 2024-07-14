//
//  CommunitySettingsViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation
import SharedResourcesClientAndServer

@MainActor @Observable
final class CommunitySettingsViewModel: SubmittableNextButtonViewModel {
    var settings: CommunitySettingsCreationRequest
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
    
    func nextButtonAction() async {
        submitCommunityInput.settings = settings
        try? await Task.sleep(nanoseconds: 150_000)
        flowCoordinator?.didSubmit(flow: .settings)
    }
    
    func onAppear() {
        settings = submitCommunityInput.settings
    }
}
