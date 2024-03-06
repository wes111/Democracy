//
//  AddRuleViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/26/24.
//

import Foundation

@Observable
final class AddRuleViewModel {
    var title: String = ""
    var description: String = ""
    var alertModel: NewAlertModel?
    
    let rules: [Rule]
    let communityName: String
    let updateRulesAction: (Rule) -> Void
    let cancelEditingAction: () -> Void
    let editingRule: Rule?
    
    init(
        rules: [Rule],
        communityName: String,
        updateRulesAction: @escaping (Rule) -> Void,
        cancelEditingAction: @escaping () -> Void,
        editingRule: Rule? = nil
    ) {
        self.rules = rules
        self.communityName = communityName
        self.updateRulesAction = updateRulesAction
        self.cancelEditingAction = cancelEditingAction
        self.editingRule = editingRule
        
        if let editingRule {
            setupFields(using: editingRule)
        }
    }
}

// MARK: - Computed Properties
extension AddRuleViewModel {
    var viewTitle: String {
        "\(editingRule == nil ? "Add" : "Edit") Community Rule"
    }
    
    var submitButtonTitle: String {
        "\(editingRule == nil ? "Add" : "Update") Rule"
    }
    
    var canSubmit: Bool {
        guard titleIsSubmittable && descriptionIsSubmittable else {
            return false
        }
        
        let rule = Rule(
            id: UUID().uuidString,
            title: title,
            description: description,
            communityId: communityName
        )
        
        if editingRule == nil {
            return !rules.contains(where: { $0.title == rule.title })
        } else {
            return true // Can alway submit, even if no changes.
        }
    }
}

// MARK: - Methods {
extension AddRuleViewModel {
    
    @MainActor
    func submit() {
        guard canSubmit else {
            return alertModel = AddRuleAlert.invalid.toNewAlertModel()
        }
        
        let rule = Rule(
            id: editingRule?.id ?? UUID().uuidString,
            title: title,
            description: description,
            communityId: communityName
        )
        
        updateRulesAction(rule)
    }
}

// MARK: - Private Computed Properties
private extension AddRuleViewModel {
    var titleIsSubmittable: Bool {
        DefaultRequirement.fullyValid(input: title)
    }
    
    var descriptionIsSubmittable: Bool {
        DefaultRequirement.fullyValid(input: description)
    }
}

// MARK: - Private Methods
private extension AddRuleViewModel {
    
    func setupFields(using rule: Rule) {
        title = rule.title
        description = rule.description
    }
}
