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
    
    func showCreateCandidateView()
    func closeCreateCandidateView()
}

protocol CandidatesViewModelProtocol: ObservableObject {
    var coordinator: CandidatesCoordinatorDelegate { get }
    var candidates: [Candidate] { get }
    var representatives: [Candidate] { get }
    var candidatesFilter: RepresentativeType { get set }
    var representativesFilter: RepresentativeType { get set }
    //var isShowingCreateCandidateView: Bool { get set }
    
    func refreshCandidates()
    func openCreateCandidateView()
    func closeCreateCandidateView()
    func getCandidateCardViewModel(_ candidate: Candidate) -> CandidateCardViewModel 
}

final class CandidatesViewModel: CandidatesViewModelProtocol {
    
    @Injected(\.candidateInteractor) var candidateInteractor
    @Published var allCandidates: [Candidate] = []
    @Published var candidatesFilter: RepresentativeType = .legislator
    @Published var representativesFilter: RepresentativeType = .legislator
    //@Published var isShowingCreateCandidateView = false
    
    let coordinator: CandidatesCoordinatorDelegate
    private var cancellables = Set<AnyCancellable>()
    
    var candidates: [Candidate] {
        allCandidates.filter({ $0.repType == candidatesFilter })
    }
    
    var representatives: [Candidate] {
        allCandidates.filter({ $0.isRepresentative && $0.repType == representativesFilter })
    }
    
    init(coordinator: CandidatesCoordinatorDelegate
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
        coordinator.showCreateCandidateView()
        //isShowingCreateCandidateView = true
    }
    
    func closeCreateCandidateView() {
        coordinator.closeCreateCandidateView()
    }
    
    func getCandidateCardViewModel(_ candidate: Candidate) -> CandidateCardViewModel {
        CandidateCardViewModel(coordinator: coordinator, candidate: candidate)
    }
    
    
}

