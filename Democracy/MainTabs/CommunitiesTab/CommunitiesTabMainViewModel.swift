//
//  CommunitiesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol CommunitiesTabMainCoordinatorDelegate {
    func tappedNav()
}

protocol CommunitiesTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class CommunitiesTabMainViewModel: CommunitiesTabMainViewModelProtocol {
    
    var coordinator: CommunitiesTabMainCoordinatorDelegate
    
    init(coordinator: CommunitiesTabMainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func tappedNav() {
        coordinator.tappedNav()
    }
}
