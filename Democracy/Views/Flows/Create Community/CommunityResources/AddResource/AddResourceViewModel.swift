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
    
    init(resources: [Resource], updateResourcesAction: @escaping (Resource) -> Void) {
        self.updateResourcesAction = updateResourcesAction
        self.resources = resources
    }
    
    // Add resource.
    @MainActor
    func submit() {
        guard canSubmit else {
            return alertModel = AddResourceAlert.invalid.toNewAlertModel()
        }
        let resource = Resource(
            title: title,
            description: description,
            url: url.isEmpty ? nil : URL(string: url),
            category: category
        )
        updateResourcesAction(resource)
    }
}

// MARK: - Computed Properties
extension AddResourceViewModel {
    
    var canSubmit: Bool {
        guard titleIsSubmittable && descriptionIsSubmittable && urlIsSubmittable else {
            return false
        }
        let resource = Resource(
            title: title,
            description: description,
            url: url.isEmpty ? nil : URL(string: url),
            category: category
        )
        return !resources.contains(resource)
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
