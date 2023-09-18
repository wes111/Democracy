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
                            candidate: candidate
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
                    ForEach(viewModel.candidates) { candidate in
                        CandidateCardView(
                            candidate: candidate
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

//MARK: - Preview
#Preview {
    CandidatesView(viewModel: CandidatesViewModel.preview)
}
