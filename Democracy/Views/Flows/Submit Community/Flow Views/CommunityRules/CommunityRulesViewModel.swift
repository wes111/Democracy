//
//  CommunityRulesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

@MainActor @Observable
final class CommunityRulesViewModel: SubmittableNextButtonViewModel {
    var rules: [Rule] = []
    var isShowingAddRuleSheet = false
    @ObservationIgnored var editingRule: Rule?
    var alertModel: NewAlertModel?
    var isShowingProgress: Bool = false
    private let submitCommunityInput: SubmitCommunityInput
    private weak var flowCoordinator: SubmitCommunityFlowCoordinator?
    
    init(submitCommunityInput: SubmitCommunityInput, flowCoordinator: SubmitCommunityFlowCoordinator?) {
        self.submitCommunityInput = submitCommunityInput
        self.flowCoordinator = flowCoordinator
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
        submitCommunityInput.rules = Set(rules)
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
        submitCommunityInput.rules = Set(rules)
        flowCoordinator?.didSubmit(flow: .rules)
    }
    
    func onAppear() {
        rules = Array(submitCommunityInput.rules)
    }
    
    func addRuleViewModel() -> AddRuleViewModel? {
        guard let communityName = submitCommunityInput.name else {
            alertModel = CreateCommunityAlert.missingName.toNewAlertModel()
            return nil
        }
        return AddRuleViewModel(
            rules: rules,
            communityName: communityName,
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
        submitCommunityInput.rules = Set(rules)
    }
}
