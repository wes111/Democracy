//
//  EventsTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

//struct CommunitiesTabCoordinator: View {
//    @StateObject private var viewModel: CommunitiesTabCoordinatorViewModel
//
//    init(viewModel: CommunitiesTabCoordinatorViewModel) {
//        _viewModel = StateObject(wrappedValue: viewModel)
//    }
//
//    var body: some View {
//        CoordinatorView(router: $viewModel.router) {
//            CommunitiesTabMainView(viewModel: viewModel.communitiesTabMainViewModel())
//        } secondaryScreen: { (path: CommunitiesTabPath) in
//            createViewFromPath(path)
//        }
//        .fullScreenCover(isPresented: $viewModel.isShowingCreateCommunityView) {
//            CreateCommunityView(viewModel: viewModel.createCommunityViewModel())
//        }
//    }
//
//    @ViewBuilder
//    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
//        switch path {
//        case .goToCommunity(let community): CommunityCoordinator(viewModel: viewModel.communityCoordinatorViewModel(community: community))
//        }
//    }
//}

struct EventsTabCoordinator: View {
    
    @StateObject private var viewModel: EventsTabCoordinatorViewModel
    
    init(viewModel: EventsTabCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        CoordinatorView(router: $viewModel.router) {
            EventsTabMainView(viewModel: viewModel.eventsTabMainViewModel())
        } secondaryScreen: { (path: EventsTabPath) in
            createViewFromPath(path)
        }
        //.fullScreenCover(item: <#T##Binding<Identifiable?>#>, content: <#T##(Identifiable) -> View#>)
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: EventsTabPath) -> some View {
        switch path {
        case .one:
            EmptyView()
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
        let viewModel = EventsTabCoordinatorViewModel()
        EventsTabCoordinator(viewModel: viewModel)
    }
}
