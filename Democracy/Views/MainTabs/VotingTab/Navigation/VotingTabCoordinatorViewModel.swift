//
//  VotingTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

@MainActor @Observable
final class VotingTabCoordinatorViewModel {
    var router = Router()
}

// MARK: - Child ViewModels
extension VotingTabCoordinatorViewModel {
    
    func votingTabMainViewModel() -> VotingTabMainViewModel {
        .init(coordinator: self)
    }
    
}

// MARK: - Protocols

extension VotingTabCoordinatorViewModel: VotingTabMainCoordinatorDelegate {
    func tappedNav() {
        print("Tapped Navigation.")
    }
}
