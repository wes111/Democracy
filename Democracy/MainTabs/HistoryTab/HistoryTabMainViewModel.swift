//
//  HistoryTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol HistoryTabMainCoordinatorDelegate {
    func tappedNav()
}

protocol HistoryTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class HistoryTabMainViewModel: HistoryTabMainViewModelProtocol {
    
    var coordinator: HistoryTabMainCoordinatorDelegate
    
    init(coordinator: HistoryTabMainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func tappedNav() {
        coordinator.tappedNav()
    }
}

