//
//  EventsTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol EventsTabMainCoordinatorDelegate {
    func tappedNav()
}

protocol EventsTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class EventsTabMainViewModel: EventsTabMainViewModelProtocol {
    
    var coordinator: EventsTabMainCoordinatorDelegate
    
    init(coordinator: EventsTabMainCoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func tappedNav() {
        coordinator.tappedNav()
    }
}
