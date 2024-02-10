//
//  RuleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import SwiftUI

struct GARBAGERuleView: View {

    var viewModel: RuleViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(viewModel.index)")
                .font(.title2)
                .padding(.trailing, 5)
                .foregroundColor(.tertiaryText)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.title)
                    .font(.bold(.body)())
                Text(viewModel.description)
                    .font(.caption)
                    .foregroundColor(.tertiaryText)
            }
        }
    }
}
