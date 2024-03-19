//
//  RulesSection.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import Foundation
import SwiftUI

struct RulesSection: View {
    
    let viewModel: RulesSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.title)
                .font(.title)
            
            ForEach(viewModel.ruleViewModels) { rule in
                VStack {
                    GARBAGERuleView(viewModel: rule)
                    
                    Divider()
                        .overlay(Color.tertiaryBackground)
                }
            }
        }
    }
}
