//
//  UpdatesTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Factory
import Foundation

@Observable
final class UpdatesTabCoordinatorViewModel {
    var router = Router()
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
