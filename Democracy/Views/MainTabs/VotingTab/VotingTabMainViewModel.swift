//
//  VotingTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol VotingTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

protocol VotingTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class VotingTabMainViewModel: VotingTabMainViewModelProtocol {
    
    private weak var coordinator: VotingTabMainCoordinatorDelegate?
    
    init(coordinator: VotingTabMainCoordinatorDelegate?) {
        self.coordinator = coordinator
    }
    
    func tappedNav() {
        coordinator?.tappedNav()
    }
}
