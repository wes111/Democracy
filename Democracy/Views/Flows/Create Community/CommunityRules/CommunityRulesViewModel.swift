//
//  CommunityRulesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@Observable
final class CommunityRulesViewModel: FlowViewModel<CreateCommunityCoordinator>, InputFlowViewModel {
    var rules: [Rule] = []
    var isShowingAddRuleSheet = false
    @ObservationIgnored var editingRule: Rule?
    
    let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.rules
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Computed Properties
extension CommunityRulesViewModel {
    var canPerformNextAction: Bool {
        // Show "skip" button if resources is empty, otherwise show "next" button.
        !rules.isEmpty
    }
}

// MARK: - Methods
extension CommunityRulesViewModel {
    
    func removeRule(_ rule: Rule) {
        guard let index = rules.firstIndex(where: { $0.id == rule.id }) else {
            return
        }
        rules.remove(at: index)
        userInput.rules = Set(rules)
    }
    
    func editRule(_ rule: Rule) {
        editingRule = rule
        isShowingAddRuleSheet = true
    }
    
    @MainActor
    func nextButtonAction() {
        guard !rules.isEmpty else {
            return presentMissingRuleAlert()
        }
        userInput.rules = Set(rules)
        coordinator?.didSubmitRules(input: userInput)
    }
    
    func onAppear() {
        rules = Array(userInput.rules)
    }
    
    func addRuleViewModel() -> AddRuleViewModel {
        AddRuleViewModel(
            rules: rules,
            updateRulesAction: newRuleAdded,
            cancelEditingAction: didCancelEditing,
            editingRule: editingRule
        )
    }
    
    @MainActor
    private func presentMissingRuleAlert() {
        alertModel = CreateCommunityAlert.missingRule.toNewAlertModel()
    }
}

// MARK: - Private Methods
private extension CommunityRulesViewModel {
    
    func didCancelEditing() {
        editingRule = nil
    }
    
    func newRuleAdded(_ rule: Rule) {
        if editingRule != nil {
            guard let index = rules.firstIndex(where: { $0.id == rule.id }) else {
                return alertModel = CreateCommunityAlert.unableToEditRule.toNewAlertModel()
            }
            rules[index] = rule
            self.editingRule = nil
        } else {
            rules.append(rule)
        }
        userInput.rules = Set(rules)
    }
}
