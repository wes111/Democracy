//
//  CommunityLeadersViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Factory
import Foundation

//@Observable
//final class CommunityRulesViewModel: SubmittableNextButtonViewModel {
//    var rules: [Rule] = []
//    var isShowingAddRuleSheet = false
//    @ObservationIgnored var editingRule: Rule?
//    var alertModel: NewAlertModel?
//    var isShowingProgress: Bool = false
//    private let submitCommunityInput: SubmitCommunityInput
//    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
//    
//    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
//        self.submitCommunityInput = submitCommunityInput
//        self.flowCoordinator = flowCoordinator
//    }
//}

@Observable
final class CommunityResourcesViewModel: SubmittableNextButtonViewModel {
    var resources: [Resource] = []
    var isShowingAddResourceSheet = false
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    @ObservationIgnored var editingResource: Resource?
    @ObservationIgnored @Injected(\.communityService) private var communityService
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
    }
}

// MARK: - Computed Properties
extension CommunityResourcesViewModel {
    var canPerformNextAction: Bool {
        true
    }
}

// MARK: - Methods
extension CommunityResourcesViewModel {
    
    func removeResource(_ resource: Resource) {
        guard let index = resources.firstIndex(where: { $0.id == resource.id }) else {
            return
        }
        resources.remove(at: index)
        submitCommunityInput.resources = resources
    }
    
    func editResource(_ resource: Resource) {
        editingResource = resource
        isShowingAddResourceSheet = true
    }
    
    @MainActor
    func nextButtonAction() async {
        guard canPerformNextAction else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        do {
            submitCommunityInput.resources = resources
            try await communityService.submitCommunity(userInput: submitCommunityInput)
            flowCoordinator?.didSubmit(flow: .resources)
        } catch {
            print(error.localizedDescription)
            alertModel = CreateCommunityAlert.createCommunityFailed.toNewAlertModel()
        }
    }
    
    func onAppear() {
        resources = submitCommunityInput.resources
    }
    
    func addResourceViewModel() -> AddResourceViewModel? {
        guard let communityName = submitCommunityInput.name else {
            alertModel = CreateCommunityAlert.missingName.toNewAlertModel()
            return nil
        }
        return AddResourceViewModel(
            resources: resources,
            communityName: communityName,
            updateResourcesAction: newResourceAdded,
            cancelEditingAction: didCancelEditing,
            editingResource: editingResource
        )
    }
}

// MARK: - Private Methods
private extension CommunityResourcesViewModel {
    
    func didCancelEditing() {
        editingResource = nil
    }
    
    func newResourceAdded(_ resource: Resource) {
        if editingResource != nil {
            guard let index = resources.firstIndex(where: { $0.id == resource.id }) else {
                return alertModel = CreateCommunityAlert.unableToEditResource.toNewAlertModel()
            }
            resources[index] = resource
            editingResource = nil
        } else {
            resources.append(resource)
        }
        submitCommunityInput.resources = resources
    }
}
