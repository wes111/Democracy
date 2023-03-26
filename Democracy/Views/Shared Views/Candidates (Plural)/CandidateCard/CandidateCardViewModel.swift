//
//  CandidateCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Combine
import Factory

protocol CandidateCardCoordinatorDelegate {
    func goToCandidateView(_ candidate: Candidate)
}

protocol CandidateCardViewModelProtocol: ObservableObject {
    func goToCandidateView()
    
    func upVoteCandidate()
    func downVoteCandidate()
}

final class CandidateCardViewModel: CandidateCardViewModelProtocol {
    
    @Injected(\.candidateInteractor) var candidateInteractor

    private let coordinator: CandidateCardCoordinatorDelegate
    @Published var candidate: Candidate
    
    init(coordinator: CandidateCardCoordinatorDelegate,
         candidate: Candidate
    ) {
        self.coordinator = coordinator
        self.candidate = candidate
    }
    
    func goToCandidateView() {
        coordinator.goToCandidateView(candidate)
    }
    
    func upVoteCandidate() {
        candidateInteractor.upVoteCandidate(candidate)
        self.candidate = try! candidateInteractor.getCandidate(id: candidate.id)
    }
    
    func downVoteCandidate() {
        candidateInteractor.downVoteCandidate(candidate)
    }
    
}
