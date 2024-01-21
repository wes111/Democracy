//
//  VotingTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

@MainActor
protocol VotingTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

@MainActor
protocol VotingTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class VotingTabMainViewModel: VotingTabMainViewModelProtocol {
    
    private weak var coordinator: VotingTabMainCoordinatorDelegate?
    
    init(coordinator: VotingTabMainCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func tappedNav() {
        coordinator?.tappedNav()
    }
}
