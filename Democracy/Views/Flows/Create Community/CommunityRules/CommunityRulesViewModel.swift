//
//  CommunityRulesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

struct Rule: Equatable, Hashable, Codable {
    let title: String
    let description: String
}

@Observable
final class CommunityRulesViewModel: FlowViewModel<CreateCommunityCoordinator>, InputFlowViewModel {
    var ruleTitle: String = ""
    var ruleDescription: String = ""
    var rules: [Rule] = []
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.rules
    let skipAction: (() -> Void)? = nil
    
    init(coordinator: CreateCommunityCoordinator, userInput: CreateCommunityInput) {
        self.userInput = userInput
        super.init(coordinator: coordinator)
    }
}

// MARK: - Methods
extension CommunityRulesViewModel {
    
    var isMissingContent: Bool {
        ruleTitle.isEmpty || ruleDescription.isEmpty
    }
    
    var canSubmit: Bool {
        guard !isMissingContent else {
            return false
        }
        let rule = Rule(title: ruleTitle, description: ruleDescription)
        guard !rules.contains(rule) else {
            return false
        }
        return true
    }
    
    var canPerformNextAction: Bool {
        !rules.isEmpty
    }
    
    @MainActor
    func nextButtonAction() async {
        guard !rules.isEmpty else {
            return presentMissingRuleAlert()
        }
        userInput.rules = Set(rules)
        coordinator?.didSubmitRules(input: userInput)
    }
    
    // Add rule.
    @MainActor
    func submit() {
        guard canSubmit else {
            return
        }
        let rule = Rule(title: ruleTitle, description: ruleDescription)
        rules.append(rule)
        ruleTitle = ""
        ruleDescription = ""
        userInput.rules = Set(rules)
    }
    
    func removeRule(_ rule: Rule) {
        guard let index = rules.firstIndex(of: rule) else {
            return
        }
        rules.remove(at: index)
        userInput.rules = Set(rules)
    }
    
    func editRule(_ rule: Rule) {
        removeRule(rule)
        ruleTitle = rule.title
        ruleDescription = rule.description
    }
    
    func onAppear() {
        rules = Array(userInput.rules)
    }
    
    @MainActor
    private func presentMissingRuleAlert() {
        alertModel = CreateCommunityAlert.missingRule.toNewAlertModel()
    }
    
    @MainActor
    private func presentRuleAlreadyAddedAlert() {
        alertModel = CreateCommunityAlert.ruleAlreadyAdded.toNewAlertModel()
    }
}
