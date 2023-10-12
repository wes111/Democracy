//
//  UpdatesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

final class UpdatesTabCoordinatorViewModel: Coordinator {
    
}

// MARK: - Child ViewModels
extension UpdatesTabCoordinatorViewModel {
    
    func updatesTabMainViewModel() -> UpdatesTabMainViewModel {
        .init()
    }
}

// MARK: - Protocols
extension UpdatesTabCoordinatorViewModel: UpdatesTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print()
    }
}
