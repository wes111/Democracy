//
//  VoteViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/29/23.
//

import Foundation

final class VoteViewModel: ObservableObject {
    
    @Published var role: RepresentativeType = .legislator
    private weak var coordinator: CommunitiesCoordinatorDelegate?
    
    init(coordinator: CommunitiesCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    lazy var leadingButtons: [TopBarContent] = {
        [.title(navigationTitle, size: .large)]
    }()
    
    lazy var trailingButtons: [TopBarContent] = {
        []
    }()
}

// MARK: Computed Properties
extension VoteViewModel {
    
    var navigationTitle: String {
        "\(role.description.capitalized) Candidates"
    }
    
    var candidateViewModels: [CandidateListItemViewModel] {
        CandidateListItemViewModel.previewArray
    }
}

// MARK: - Methods
extension VoteViewModel {
    
    @MainActor
    func goBack() {
        coordinator?.goBack()
    }
    
}
