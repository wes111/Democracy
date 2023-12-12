//
//  CandidateCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import SwiftUI

struct CandidateCardView: View {
    
    @StateObject private var viewModel: CandidateCardViewModel
    
    init(candidate: Candidate) {
        _viewModel = StateObject(wrappedValue: CandidateCardViewModel(candidate: candidate))
    }
    
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
        
//        VStack {
//            if let imageName = viewModel.candidate.imageName {
//                Image(imageName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(maxHeight: 150)
//            }
//
//            HStack {
//                VStack {
//                    Text(viewModel.candidate.userName)
//                    Text(viewModel.candidate.repType.rawValue)
//                }
//
//                VStack {
//                    Button {
//                        viewModel.downVoteCandidate()
//                    } label: {
//                        Image(systemName: "arrow.down")
//                    }
//                    Text("\(viewModel.candidate.downVotes)")
//                }
//                VStack {
//                    Button {
//                        viewModel.upVoteCandidate()
//                    } label: {
//                        Image(systemName: "arrow.up")
//                    }
//                    Text("\(viewModel.candidate.upVotes)")
//                }
//            }
//        }
//        .onTapGesture {
//            viewModel.goToCandidateView()
//        }
    }
}

// MARK: - Preview
#Preview {
    CandidateCardView(candidate: Candidate.preview)
}
