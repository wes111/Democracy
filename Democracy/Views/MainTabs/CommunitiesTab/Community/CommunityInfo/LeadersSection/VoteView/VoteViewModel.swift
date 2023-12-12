//
//  VoteViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 8/29/23.
//

import Foundation

protocol VoteViewCoordinator: AnyObject {
    func goBack()
}

final class VoteViewModel: ObservableObject {
    
    @Published var role: RepresentativeType = .legislator
    private weak var coordinator: VoteViewCoordinator?
    
    init(coordinator: VoteViewCoordinator) {
        self.coordinator = coordinator
    }
    
    var topButtons: [OnboardingTopButton: () -> Void] {
        [
            .back: {},
            .close: {}
        ]
    }
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
    
    func goBack() {
        coordinator?.goBack()
    }
    
}
