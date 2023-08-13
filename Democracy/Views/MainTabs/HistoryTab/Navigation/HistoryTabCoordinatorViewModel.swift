//
//  HistoryTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

final class HistoryTabCoordinatorViewModel: Coordinator {
    
}

// MARK: - Child ViewModels
extension HistoryTabCoordinatorViewModel {
    
    func historyTabMainViewModel() -> HistoryTabMainViewModel {
        .init(coordinator: self)
    }
}

// MARK: - Protocols
extension HistoryTabCoordinatorViewModel: HistoryTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print()
    }
}