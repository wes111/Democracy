//
//  CommunityRulesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import Foundation

struct Rule: Equatable, Hashable {
    let title: String
    let description: String
}

@Observable
final class CommunityRulesViewModel: FlowViewModel<CreateCommunityCoordinator>, InputFlowViewModel {
    var ruleTitle: String = ""
    var ruleDescription: String = ""
    var rules: [Rule] = [Rule(title: "Party Rule", description: "There will be no monkeys jumping on the bed because one fell off and bumped his head and the doctor said")]
    
    @ObservationIgnored private let userInput: CreateCommunityInput
    let flowCase = CreateCommunityFlow.rules
    let skipAction: (() -> Void)? = nil
    var title: String = "Community Rules"
    var subtitle: String = "Add rules that community members must follow."
    
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
        rules.insert(rule, at: 0)
        ruleTitle = ""
        ruleDescription = ""
    }
    
    func removeRule(_ rule: Rule) {
        guard let index = rules.firstIndex(of: rule) else {
            return
        }
        rules.remove(at: index)
    }
    
    func editRule(_ rule: Rule) {
        removeRule(rule)
        ruleTitle = rule.title
        ruleDescription = rule.description
    }
    
    func showExpandedRule(_ rule: Rule) {
        // TODO: ...
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
