//
//  RulesSectionViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import Foundation

struct RulesSectionViewModel {
    
    let ruleViewModels: [RuleViewModel]
    let title: String
    
    init(
        rules: [GARBAGERule],
        title: String
    ) {
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

struct GARBAGERule: Codable, Hashable {
    let id: String
    let title: String
    let description: String
    
    func viewModel(index: Int) -> RuleViewModel {
        .init(
            title: title,
            description: description,
            index: index
        )
    }
}
