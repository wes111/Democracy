//
//  LeadersScrollView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import SwiftUI

struct LeadersScrollView: View {
    
    let viewModel: LeadersScrollViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(viewModel.title)
                .font(.callout)
                .foregroundColor(.secondaryText)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.leaders) { leader in
                        LeaderView(viewModel: leader)
                            .onTapGesture {
                                viewModel.onTapLeader(id: leader.id)
                            }
                            .padding(.leading)
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = LeadersScrollViewModel(
        candidates: Candidate.previewArray,
        repType: .mod,
        coordinator: CommunitiesCoordinator.preview
    )
    return LeadersScrollView(viewModel: viewModel)
}
