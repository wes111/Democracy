//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

enum CommunitiesTabPath: Hashable {
    case one
    case goToCommunity(Community)
}

struct CommunitiesTabCoordinator: View {

    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createCommunitiesTabMainView()
                .navigationDestination(for: CommunitiesTabPath.self) { path in
                    createViewFromPath(path)
                }
        }
        .environmentObject(router)
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .one: Text("")
        case .goToCommunity(let community): createCommunityView(community)
        }
    }
    
    func createCommunitiesTabMainView() -> CommunitiesTabMainView<CommunitiesTabMainViewModel> {
        let viewModel = CommunitiesTabMainViewModel(coordinator: self)
        return CommunitiesTabMainView(viewModel: viewModel)
    }
    
    func createCommunityView(_ community: Community) -> CommunityView<CommunityViewModel> {
        let coordinator = CommunityCoordinator(community)
        let viewModel = CommunityViewModel(coordinator: coordinator, community: community)
        return CommunityView(viewModel: viewModel)
    }
}

extension CommunitiesTabCoordinator: CommunitiesTabMainCoordinatorDelegate {
    
    func goToCommunity(_ community: Community) {
        router.push(CommunitiesTabPath.goToCommunity(community))
    }
    
}

struct CommunitiesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabCoordinator()
    }
}
