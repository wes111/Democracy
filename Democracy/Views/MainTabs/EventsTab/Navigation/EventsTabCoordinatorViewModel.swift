//
//  EventsTabCoordinatorViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 7/31/23.
//

import Foundation

final class EventsTabCoordinatorViewModel: Coordinator {
    
}

//MARK: - Child ViewModels
extension EventsTabCoordinatorViewModel {
    
    func eventsTabMainViewModel() -> EventsTabMainViewModel {
        .init(coordinator: self)
    }
}

// MARK: - Protocols
extension EventsTabCoordinatorViewModel: EventsTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print()
    }
}