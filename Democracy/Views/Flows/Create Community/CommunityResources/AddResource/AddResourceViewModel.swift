//
//  AddResourceViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/11/24.
//

import Foundation

@Observable
final class AddResourceViewModel {
    
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var category: ResourceCategory = .book
    var alertModel: NewAlertModel?
    
    let resources: [Resource]
    let updateResourcesAction: (Resource) -> Void
    let cancelEditingAction: () -> Void
    let editingResource: Resource?
    
    init(
        resources: [Resource],
        updateResourcesAction: @escaping (Resource) -> Void,
        cancelEditingAction: @escaping () -> Void,
        editingResource: Resource? = nil
    ) {
        self.resources = resources
        self.updateResourcesAction = updateResourcesAction
        self.cancelEditingAction = cancelEditingAction
        self.editingResource = editingResource
        
        if let editingResource {
            setupFields(using: editingResource)
        }
    }
}

// MARK: - Computed Properties
extension AddResourceViewModel {
    
    var viewTitle: String {
        "\(editingResource == nil ? "Add" : "Edit") Community Resource"
    }
    
    var submitButtonTitle: String {
        "\(editingResource == nil ? "Add" : "Update") Resource"
    }
    
    var canSubmit: Bool {
        guard titleIsSubmittable && descriptionIsSubmittable && urlIsSubmittable else {
            return false
        }
        let resource = Resource(
            id: UUID().uuidString,
            title: title,
            description: description,
            url: url.isEmpty ? nil : URL(string: url),
            category: category
        )
        if editingResource == nil {
            return !resources.contains(where: { $0.title == resource.title })
        } else {
            return true // Can alway submit, even if no changes.
        }
    }
}

// MARK: - Private Computed Properties
private extension AddResourceViewModel {
    
    var titleIsSubmittable: Bool {
        DefaultRequirement.fullyValid(input: title)
    }
    
    var descriptionIsSubmittable: Bool {
        description.isEmpty || DefaultRequirement.fullyValid(input: description)
    }
    
    var urlIsSubmittable: Bool {
        url.isEmpty || LinkRequirement.fullyValid(input: url)
    }
}

// MARK: - Methods {
extension AddResourceViewModel {
    
    // Add resource.
    @MainActor
    func submit() {
        guard canSubmit else {
            return alertModel = AddResourceAlert.invalid.toNewAlertModel()
        }
        let resource = Resource(
            id: editingResource?.id ?? UUID().uuidString,
            title: title,
            description: description,
            url: url.isEmpty ? nil : URL(string: url),
            category: category
        )
        updateResourcesAction(resource)
    }
}

// MARK: - Private Methods
private extension AddResourceViewModel {
    
    func setupFields(using resource: Resource) {
        title = resource.title
        description = resource.description ?? ""
        url = resource.url?.absoluteString ?? ""
        category = resource.category
    }
}
