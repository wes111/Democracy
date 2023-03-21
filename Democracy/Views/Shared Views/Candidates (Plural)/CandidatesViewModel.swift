//
//  CandidatesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Combine
import Factory

protocol CandidatesCoordinatorDelegate: CandidateCardCoordinatorDelegate {
}

protocol CandidatesViewModelProtocol: ObservableObject {
    var coordinator: CandidatesCoordinatorDelegate { get }
    var candidates: [Candidate] { get }
    
    func refreshPosts()
}

final class CandidatesViewModel: CandidatesViewModelProtocol {
    
    @Injected(\.candidateInteractor) var candidateInteractor
    @Published var candidates: [Candidate] = []

    let coordinator: CandidatesCoordinatorDelegate
    
    init(coordinator: CandidatesCoordinatorDelegate
    ) {
        self.coordinator = coordinator
        candidateInteractor.subscribeToCandidates().assign(to: &$candidates)
    }
    
    func refreshPosts() {
        candidateInteractor.refreshPosts()
    }
    
}

