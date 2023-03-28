//
//  CandidatesView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import SwiftUI

struct CandidatesView<ViewModel: CandidatesViewModelProtocol>: View {
    
    @StateObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        VStack {
            Button {
                viewModel.showCreateCandidateView()
            } label: {
                Image(systemName: "plus")
            }

            ScrollView {
                
    //            LazyVGrid(columns: columns) {
    //                ForEach(viewModel.representatives) { representative in
    //                    // TODO: Create slightly different card for reps.
    //                    createCandidateCardView(representative)
    //                }
    //            }
                
                Divider().padding(.top, 200)
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.candidates) { candidate in
                        createCandidateCardView(candidate)
                    }
                }
            }
        }
        
        .padding()
        .refreshable {
            viewModel.refreshRepresentatives()
            viewModel.refreshCandidates()
        }
        .fullScreenCover(isPresented: $viewModel.isShowingCreateCandidateView) {
            createCreateCandidateView()
        }
    }
    
    func createCandidateCardView(_ candidate: Candidate) -> CandidateCardView<CandidateCardViewModel> {
        let viewModel = CandidateCardViewModel(coordinator: viewModel.coordinator, candidate: candidate)
        return CandidateCardView(viewModel: viewModel)
    }
    
    func createCreateCandidateView() -> CreateCandidateView<CreateCandidateViewModel> {
        let viewModel = CreateCandidateViewModel(coordinator: self)
        return CreateCandidateView(viewModel: viewModel)
    }
}

extension CandidatesView: CreateCandidateCoordinatorDelegate {
    
    func closeCreateCandidateView() {
        viewModel.isShowingCreateCandidateView = false
    }
}

struct CandidatesView_Previews: PreviewProvider {
    static var previews: some View {
        CandidatesView(viewModel: CandidatesViewModel.preview)
    }
}
