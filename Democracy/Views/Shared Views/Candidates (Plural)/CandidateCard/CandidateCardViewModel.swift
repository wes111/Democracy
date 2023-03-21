//
//  CandidateCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation

protocol CandidateCardCoordinatorDelegate {
    func goToCandidateView(_ candidate: Candidate)
}

protocol CandidateCardViewModelProtocol: ObservableObject {
    func goToCandidateView()
}

final class CandidateCardViewModel: CandidateCardViewModelProtocol {
    
    private let coordinator: CandidateCardCoordinatorDelegate
    let candidate: Candidate
    
    init(coordinator: CandidateCardCoordinatorDelegate,
         candidate: Candidate
    ) {
        self.coordinator = coordinator
        self.candidate = candidate
    }
    
    func goToCandidateView() {
        coordinator.goToCandidateView(candidate)
    }
    
    func noAction() {
        print("No Action.")
    }
    
}
