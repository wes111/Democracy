//
//  EventsTabCoordinator+Preview.swift
//  Democracy
//
//  Created by Wesley Luntsford on 3/10/23.
//

import Foundation

extension EventsTabCoordinator {
    @MainActor static let preview = EventsTabCoordinator(viewModel: .preview)
}
extension EventsTabCoordinatorViewModel {
    static let preview = EventsTabCoordinatorViewModel()
}
