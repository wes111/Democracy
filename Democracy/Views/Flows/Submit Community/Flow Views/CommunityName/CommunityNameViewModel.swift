//
//  CommunityNameViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Factory
import Foundation

@MainActor @Observable
final class CommunityNameViewModel: SubmittableTextInputViewModel {
    typealias Requirement = DefaultRequirement
    typealias FocusedField = CommunityFlow.ID
    
    var text: String = ""
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    let fieldTitle: String = "Community Name"
    let field: CommunityFlow.ID = .name
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    @ObservationIgnored @Injected(\.communityService) private var communityService
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Methods
extension CommunityNameViewModel {
    func nextButtonAction() async {
        do {
            guard Requirement.fullyValid(input: text) else {
                return alertModel = Requirement.invalidAlert
            }
            guard try await communityService.isCommunityNameAvailable(text) else {
                return alertModel = CreateCommunityAlert.nameUnavailable.toNewAlertModel()
            }
            submitCommunityInput.name = text
            // Unclear why this is needed... Possibly a View somewhere missing an @MainActor annotation?
            try? await Task.sleep(nanoseconds: 150_000)
            flowCoordinator?.didSubmit(flow: .name)
        } catch {
            print(error.localizedDescription)
            alertModel = NewAlertModel.genericAlert
        }
    }
    
    func onAppear() {
        text = submitCommunityInput.name ?? ""
    }
}
