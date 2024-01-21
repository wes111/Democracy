//
//  HistoryTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

@Observable
final class HistoryTabCoordinatorViewModel {
    var router = Router()
}

// MARK: - Child ViewModels
extension HistoryTabCoordinatorViewModel {
    
    func historyTabMainViewModel() -> HistoryTabMainViewModel {
        .init()
    }
}

// MARK: - Protocols
extension HistoryTabCoordinatorViewModel: HistoryTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print()
    }
}
