//
//  EventsTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct EventsTabCoordinator: View {
    
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createEventsTabMainView()
                .navigationDestination(for: EventsTabPath.self) { path in
                    createViewFromPath(path)
                }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: EventsTabPath) -> some View {
        switch path {
        case .one: Text("")
        }
    }
    
    func createEventsTabMainView() -> EventsTabMainView<EventsTabMainViewModel> {
        let viewModel = EventsTabMainViewModel(coordinator: self)
        return EventsTabMainView(viewModel: viewModel)
    }
}

extension EventsTabCoordinator: EventsTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print("tapped nav")
    }
    
}

struct EventsTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        EventsTabCoordinator()
    }
}
