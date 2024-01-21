//
//  EventsTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

@Observable
final class EventsTabCoordinatorViewModel {
    var router = Router()
}

// MARK: - Child ViewModels
extension EventsTabCoordinatorViewModel {
    
    func eventsTabMainViewModel() -> EventsTabMainViewModel {
        .init()
    }
}

// MARK: - Protocols
extension EventsTabCoordinatorViewModel: EventsTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print()
    }
}
