//
//  CommunityLeadersViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Factory
import Foundation

@Observable
final class CommunityResourcesViewModel: FlowViewModel<CreateCommunityCoordinator>, InputFlowViewModel {
    
    var resources: [Resource] = []
    var isShowingAddResourceSheet = false
    
    @ObservationIgnored var editingResource: Resource?
    @ObservationIgnored @Injected(\.communityService) private var communityService
    
    let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.resources
    let canPerformNextAction: Bool = true
    var skipAction: (() -> Void)? = nil // Not skippable (can always perform next action).
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Methods
extension CommunityResourcesViewModel {
    
    func removeResource(_ resource: Resource) {
        guard let index = resources.firstIndex(where: { $0.id == resource.id }) else {
            return
        }
        resources.remove(at: index)
        userInput.resources = resources
    }
    
    func editResource(_ resource: Resource) {
        editingResource = resource
        isShowingAddResourceSheet = true
    }
    
    @MainActor
    func nextButtonAction() async {
        guard canSubmit else {
            return alertModel = NewAlertModel.genericAlert
        }
        
        do {
            userInput.resources = resources
            try await communityService.submitCommunity(userInput: userInput)
            coordinator?.didSubmitResources(input: userInput)
        } catch {
            print(error.localizedDescription)
            alertModel = CreateCommunityAlert.createCommunityFailed.toNewAlertModel()
        }
    }
    
    func onAppear() {
        resources = userInput.resources
    }
    
    func addResourceViewModel() -> AddResourceViewModel? {
        guard let communityName = userInput.name else {
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
        userInput.resources = resources
    }
}
