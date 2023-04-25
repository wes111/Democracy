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
    
    var body: some View {
        List {
            Group {
                Section {
                    ForEach(viewModel.representatives) { candidate in
                        CandidateCardView(
                            viewModel: viewModel.getCandidateCardViewModel(candidate)
                        )
                    }
                } header: {
                    HeaderWithDropDownFilter(
                        title: "Representatives",
                        menuItems: RepresentativeType.allCases,
                        selectedItem: $viewModel.representativesFilter
                    )
                }
                
                Section {
                    ForEach(viewModel.candidates) { representative in
                        CandidateCardView(
                            viewModel: viewModel.getCandidateCardViewModel(representative)
                        )
                    }
                } header: {
                    HeaderWithDropDownFilter(
                        title: "Candidates",
                        menuItems: RepresentativeType.allCases,
                        selectedItem: $viewModel.candidatesFilter
                    )
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)

        }
        .headerProminence(.increased)
        .listStyle(PlainListStyle())
        .refreshable {
            viewModel.refreshCandidates()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.openCreateCandidateView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct CandidatesView_Previews: PreviewProvider {
    static var previews: some View {
        CandidatesView(viewModel: CandidatesViewModel.preview)
    }
}
