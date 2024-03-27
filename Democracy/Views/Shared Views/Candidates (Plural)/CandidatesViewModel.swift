//
//  CandidatesViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//

import Foundation
import Combine
import Factory

protocol CandidatesViewModelProtocol: ObservableObject {
    var coordinator: CommunitiesCoordinatorDelegate? { get }
    var candidates: [Candidate] { get }
    var representatives: [Candidate] { get }
    var candidatesFilter: RepresentativeType { get set }
    var representativesFilter: RepresentativeType { get set }
    // var isShowingCreateCandidateView: Bool { get set }
    
    func refreshCandidates()
    @MainActor func openCreateCandidateView()
    @MainActor func closeCreateCandidateView()
    func getCandidateCardViewModel(_ candidate: Candidate) -> CandidateCardViewModel
}

final class CandidatesViewModel: CandidatesViewModelProtocol {
    
    @Injected(\.candidateInteractor) var candidateInteractor
    @Published var allCandidates: [Candidate] = []
    @Published var candidatesFilter: RepresentativeType = .legislator
    @Published var representativesFilter: RepresentativeType = .legislator
    // @Published var isShowingCreateCandidateView = false
    
    weak var coordinator: CommunitiesCoordinatorDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    var candidates: [Candidate] {
        allCandidates.filter({ $0.repType == candidatesFilter })
    }
    
    var representatives: [Candidate] {
        allCandidates.filter({ $0.isRepresentative && $0.repType == representativesFilter })
    }
    
    init(
        coordinator: CommunitiesCoordinatorDelegate?
    ) {
        self.coordinator = coordinator
        candidateInteractor
            .subscribeToCandidates()
            .receive(on: DispatchQueue.main)
            .assign(to: &$allCandidates)
    }
    
    func refreshCandidates() {
        candidateInteractor.refreshCandidates()
    }
    
    func openCreateCandidateView() {
        coordinator?.showCreateCandidateView()
        // isShowingCreateCandidateView = true
    }
    
    func closeCreateCandidateView() {
        coordinator?.closeCreateCandidateView()
    }
    
    func getCandidateCardViewModel(_ candidate: Candidate) -> CandidateCardViewModel {
        CandidateCardViewModel(candidate: candidate)
    }
}
