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
    
    @StateObject private var viewModel: CommunitiesTabCoordinatorViewModel
    @ObservedObject private var router: Router
    
    init(viewModel: CommunitiesTabCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        router = viewModel.router
    }

    var body: some View {
        NavigationStack(path: $viewModel.router.navigationPath) {
            CommunitiesTabMainView(viewModel: viewModel.communitiesTabMainViewModel)
                .navigationDestination(for: CommunitiesTabPath.self) { path in
                    createViewFromPath(path)
                }
                .fullScreenCover(isPresented: $viewModel.isShowingCreateCommunityView) {
                    CreateCommunityView(viewModel: viewModel.createCommunityViewModel)
                }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .goToCommunity(let community): CommunityCoordinator(viewModel: viewModel.communityCoordinatorViewModel(community: community))
        }
    }
    
}

struct CommunitiesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabCoordinator(viewModel: .preview)
    }
}
