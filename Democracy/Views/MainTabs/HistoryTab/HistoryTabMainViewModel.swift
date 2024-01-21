//
//  HistoryTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

@MainActor
protocol HistoryTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

protocol HistoryTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class HistoryTabMainViewModel: HistoryTabMainViewModelProtocol {
    
    // private weak var coordinator: HistoryTabMainCoordinatorDelegate?
    
    init() {
        // self.coordinator = coordinator
    }
    
    func tappedNav() {
        // coordinator?.tappedNav()
    }
}
