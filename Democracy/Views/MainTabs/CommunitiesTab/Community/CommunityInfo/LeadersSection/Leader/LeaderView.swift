//
//  LeaderView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import SwiftUI

//TODO: This overlaps with CandidateView.
struct LeaderView: View {
    
    let viewModel: LeaderViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Image(viewModel.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            HStack {
                Text(viewModel.candidateName)
                    .font(.caption)
                    .padding(4)
                    .frame(width: 100)
            }
            .background(
                Rectangle()
                    .foregroundColor(Color.secondaryBackground)
            )
        }
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//MARK: - Preview
#Preview {
    let viewModel = LeaderViewModel(candidate: .preview)
    return LeaderView(viewModel: viewModel)
}
