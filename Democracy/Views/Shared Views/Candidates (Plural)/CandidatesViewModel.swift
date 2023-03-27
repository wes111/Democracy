//
//  CandidatesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation
import Combine
import Factory

protocol CandidatesCoordinatorDelegate: CandidateCardCoordinatorDelegate {
}

protocol CandidatesViewModelProtocol: ObservableObject {
    var coordinator: CandidatesCoordinatorDelegate { get }
    var candidates: [Candidate] { get }
    var representatives: [Candidate] { get }
    
    func refreshCandidates()
    func refreshRepresentatives()
    func addCandidate()
}

final class CandidatesViewModel: CandidatesViewModelProtocol {
    
    @Injected(\.candidateInteractor) var candidateInteractor
    @Injected(\.communityInteractor) var communityInteractor
    @Published var candidates: [Candidate] = []
    @Published var representatives: [Candidate] = []

    let coordinator: CandidatesCoordinatorDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: CandidatesCoordinatorDelegate
    ) {
        self.coordinator = coordinator
        candidateInteractor.subscribeToCandidates()
            .receive(on: DispatchQueue.main)
            .assign(to: &$candidates)
        
        communityInteractor.subscribeToRepresentatives().assign(to: &$representatives)
    }
    
    func refreshCandidates() {
        candidateInteractor.refreshCandidates()
    }
    
    func refreshRepresentatives() {
        communityInteractor.refreshRepresentatives()
    }
    
    func addCandidate() {
        Task {
            do {
                //TODO: ...
                try await candidateInteractor.addCandidate(Candidate.preview)
            } catch {
               print("Failed to add candidate, error: \(error)")
            }
        }
        
    }
    
}

