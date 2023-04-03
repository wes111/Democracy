//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

enum CommunitiesTabPath: Hashable {
    case goToCommunity(Community)
}

struct CommunitiesTabCoordinator: View {

    @StateObject private var router = Router()
    @State private var isShowingCreateCommunityView = false
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createCommunitiesTabMainView()
                .navigationDestination(for: CommunitiesTabPath.self) { path in
                    createViewFromPath(path)
                }
                .fullScreenCover(isPresented: $isShowingCreateCommunityView) {
                    createCreateCommunityView()
                }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .goToCommunity(let community): createCommunityView(community)
        }
    }
    
    func createCommunitiesTabMainView() -> CommunitiesTabMainView<CommunitiesTabMainViewModel> {
        let viewModel = CommunitiesTabMainViewModel(coordinator: self)
        return CommunitiesTabMainView(viewModel: viewModel)
    }
    
    func createCommunityView(_ community: Community) -> CommunityCoordinator {
        CommunityCoordinator(community, router)
    }
    
    func createCreateCommunityView() -> CreateCommunityView<CreateCommunityViewModel> {
        let viewModel = CreateCommunityViewModel(coordinator: self)
        return CreateCommunityView(viewModel: viewModel)
    }
    
}

extension CommunitiesTabCoordinator: CommunitiesTabMainCoordinatorDelegate {
    
    func showCreateCommunityView() {
        isShowingCreateCommunityView = true
    }
    
    
    func goToCommunity(_ community: Community) {
        router.push(CommunitiesTabPath.goToCommunity(community))
    }
    
}

extension CommunitiesTabCoordinator: CreateCommunityCoordinatorDelegate {
    
    func close() {
        isShowingCreateCommunityView = false
    }
}

struct CommunitiesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabCoordinator()
    }
}
