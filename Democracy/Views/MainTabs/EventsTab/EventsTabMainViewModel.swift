//
//  EventsTabMainViewModel.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import Foundation

protocol EventsTabMainCoordinatorDelegate: AnyObject {
    func tappedNav()
}

protocol EventsTabMainViewModelProtocol: ObservableObject {
    func tappedNav()
}

final class EventsTabMainViewModel: EventsTabMainViewModelProtocol {
    
    //private weak var coordinator: EventsTabMainCoordinatorDelegate?
    
    init() {
        //self.coordinator = coordinator
    }
    
    func tappedNav() {
        //coordinator?.tappedNav()
    }
}
