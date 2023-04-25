//
//  CandidateCardViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Combine
import Factory
import Foundation

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
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: CandidateCardCoordinatorDelegate,
         candidate: Candidate
    ) {
        self.coordinator = coordinator
        self.candidate = candidate
        
        subscribeToCandidates()
    }
    
    /// Subscribe to updates to the card's candidate.
    private func subscribeToCandidates() {
        candidateInteractor
            .subscribeToCandidates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] candidates in
                guard let self = self, let cardCandidate = candidates.first(where: { $0.id == self.candidate.id }) else {
                    return print("Candidate for card went missing from local database.")
                }
                self.updateCandidate(newCandidate: cardCandidate)
            }
        .store(in: &cancellables)
    }
    
    /// Update the card's candidate on the main thread.
    private func updateCandidate(newCandidate: Candidate) {
        Task {
            await MainActor.run {
                self.candidate = newCandidate
            }
        }
    }
    
    func goToCandidateView() {
        coordinator.goToCandidateView(candidate)
    }
    
    func upVoteCandidate() {
        Task {
            do {
                try await candidateInteractor.upVoteCandidate(candidate)
            } catch {
                print("Failed to up vote candidate, error: \(error)")
            }
        }
    }
    
    func downVoteCandidate() {
        Task {
            do {
                try await candidateInteractor.downVoteCandidate(candidate)
            } catch {
                print("Failed to down vote candidate, error: \(error)")
            }
        }
    }
    
}
