//
//  CandidateCardView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import SwiftUI

struct CandidateCardView<ViewModel: CandidateCardViewModel>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            if let imageName = viewModel.candidate.imageName {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 150)
            }
            
            HStack {
                Text(viewModel.candidate.userName)
                VStack {
                    Button {
                        viewModel.downVoteCandidate()
                    } label: {
                        Image(systemName: "arrow.down")
                    }
                    Text("\(viewModel.candidate.downVotes)")
                }
                VStack {
                    Button {
                        viewModel.upVoteCandidate()
                    } label: {
                        Image(systemName: "arrow.up")
                    }
                    Text("\(viewModel.candidate.upVotes)")
                }
                



                
                
            }
            
        }
        .onTapGesture {
            viewModel.goToCandidateView()
        }
    }
}

struct CandidateCardView_Previews: PreviewProvider {
    static var previews: some View {
        CandidateCardView(viewModel: CandidateCardViewModel.preview)
    }
}
