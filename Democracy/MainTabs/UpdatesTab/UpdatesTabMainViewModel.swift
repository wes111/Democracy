//
//  UpdatesTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol UpdatesTabMainCoordinatorDelegate {
    func tappedNav()
}

protocol UpdatesTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class UpdatesTabMainViewModel: UpdatesTabMainViewModelProtocol {
    
    var coordinator: UpdatesTabMainCoordinatorDelegate
    
    init(coordinator: UpdatesTabMainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func tappedNav() {
        coordinator.tappedNav()
    }
}
