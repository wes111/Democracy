//
//  RulesSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import Foundation

struct RulesSectionViewModel {
    
    private let rules: [Rule]
    let ruleViewModels: [RuleViewModel]
    
    let title: String
    
    init(
        rules: [Rule],
        title: String
    ) {
        self.rules = rules
        self.title = title
        
        ruleViewModels = {
            var viewModels: [RuleViewModel] = []
            for (index, rule) in rules.enumerated() {
                viewModels.append(rule.viewModel(index: index))
            }
            return viewModels
        }()
    }
}
