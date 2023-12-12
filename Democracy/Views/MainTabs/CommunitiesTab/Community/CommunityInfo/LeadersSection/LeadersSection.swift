//
//  LeadersSection.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import SwiftUI

struct LeadersSection: View {
    
    let viewModel: LeadersSectionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                
                Text("Representatives")
                    .font(.title)
                
                Spacer()
                
                Button {
                    viewModel.tappedVote()
                } label: {
                    Text("Vote")
                        .font(.title3)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.otherRed)
                        )
                }
            }
            .padding(.horizontal)
            
            LeadersScrollView(viewModel: viewModel.creatorsScrollViewModel)
            
            LeadersScrollView(viewModel: viewModel.modsScrollViewModel)
            
            LeadersScrollView(viewModel: viewModel.legislatorsScrollViewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = LeadersSectionViewModel(
        creators: Candidate.previewArray,
        mods: Candidate.previewArray,
        legislators: Candidate.previewArray, coordinator: CommunityCoordinator.preview
    )
    
    return LeadersSection(viewModel: viewModel)
}
