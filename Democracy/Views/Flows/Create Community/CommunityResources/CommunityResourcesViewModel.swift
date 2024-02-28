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
    @ObservationIgnored var editingResource: Resource?
    
    let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.resources
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension CommunityResourcesViewModel {
    var canPerformNextAction: Bool {
        // Show "skip" button if resources is empty, otherwise show "next" button.
        !resources.isEmpty
    }
    
    @MainActor
    var skipAction: (() -> Void)? {
        nextButtonAction
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
    func nextButtonAction() {
        userInput.resources = resources
        coordinator?.didSubmitResources(input: userInput)
    }
    
    func onAppear() {
        resources = userInput.resources
    }
    
    func addResourceViewModel() -> AddResourceViewModel {
        AddResourceViewModel(
            resources: resources,
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
