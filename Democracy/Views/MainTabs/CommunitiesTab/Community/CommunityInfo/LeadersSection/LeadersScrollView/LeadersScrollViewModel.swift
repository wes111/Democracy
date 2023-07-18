//
//  LeadersScrollViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/10/23.
//

import Foundation

protocol LeadersScrollViewModelCoordinatorDelegate {
    
    func goToCandidateView(candidateId: UUID)
}

struct LeadersScrollViewModel {
    
    let leaders: [LeaderViewModel]

    var title: String {
        repType.description.capitalized
    }
    
    private let candidates: [Candidate]
    private let repType: RepresentativeType
    private let coordinator: LeadersScrollViewModelCoordinatorDelegate
    
    init(
        candidates: [Candidate],
        repType: RepresentativeType,
        coordinator: LeadersScrollViewModelCoordinatorDelegate
    ) {
        self.candidates = candidates
        self.repType = repType
        self.coordinator = coordinator
        leaders = candidates.map{ .init(candidate: $0) }
    }
    
    func onTapLeader(id: UUID) {
        coordinator.goToCandidateView(candidateId: id)
    }

}
