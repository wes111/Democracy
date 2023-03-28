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
    var isShowingCreateCandidateView: Bool { get set }
    
    func refreshCandidates()
    func refreshRepresentatives()
    func showCreateCandidateView()
}

final class CandidatesViewModel: CandidatesViewModelProtocol {
    
    @Injected(\.candidateInteractor) var candidateInteractor
    @Injected(\.communityInteractor) var communityInteractor
    @Published var candidates: [Candidate] = []
    @Published var representatives: [Candidate] = []
    @Published var isShowingCreateCandidateView = false

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
    
    func showCreateCandidateView() {
        isShowingCreateCandidateView = true
    }
    
    
}

