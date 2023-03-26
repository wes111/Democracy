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
}

final class CandidatesViewModel: CandidatesViewModelProtocol {
    
    //TODO: Should representatives be in the CandidateInteractor?
    @Injected(\.candidateInteractor) var candidateInteractor
    @Injected(\.communityInteractor) var communityInteractor
    @Published var candidates: [Candidate] = []
    @Published var representatives: [Candidate] = []

    let coordinator: CandidatesCoordinatorDelegate
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: CandidatesCoordinatorDelegate
    ) {
        self.coordinator = coordinator
        //candidateInteractor.subscribeToCandidates().assign(to: &$candidates)
        communityInteractor.subscribeToRepresentatives().assign(to: &$representatives)
        //candidateInteractor.subscribeToCandidates().receive(on: DispatchQueue.main).assign(to: &$candidates)
        bob()
    }
    
    func bob() {
        candidateInteractor.subscribeToCandidates().sink { candidates in
            Task {
                await MainActor.run(body: {
                    self.candidates = candidates
                })
            }
        }.store(in: &cancellables)
    }
    
    func refreshCandidates() {
        candidateInteractor.refreshCandidates()
    }
    
    func refreshRepresentatives() {
        communityInteractor.refreshRepresentatives()
    }
    
}

