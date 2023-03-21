//
//  CandidateViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/20/23.
//


import Foundation

protocol CandidateCoordinatorDelegate {
}

protocol CandidateViewModelProtocol: ObservableObject {
    var candidate: Candidate { get }
}

final class CandidateViewModel: CandidateViewModelProtocol {
    
    let candidate: Candidate
    private let coordinator: CandidateCoordinatorDelegate
    
    init(coordinator: CandidateCoordinatorDelegate,
         candidate: Candidate
    ) {
        self.coordinator = coordinator
        self.candidate = candidate
    }
    
}

