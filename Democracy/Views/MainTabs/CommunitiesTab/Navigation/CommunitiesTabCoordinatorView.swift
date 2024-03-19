//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabCoordinatorView: View {
    @State private var coordinator: CommunitiesTabCoordinator
    
    init(coordinator: CommunitiesTabCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            CommunitiesTabMainView(viewModel: coordinator.communitiesTabMainViewModel())
        } secondaryScreen: { (path: CommunitiesTabPath) in
            createViewFromPath(path)
        }
        // TODO: This should be a fullScreenCover not popover.
        // This temporarily fixes an iOS 17 memory leak.
        // https://developer.apple.com/forums/thread/736239
        //            .fullScreenCover(isPresented: $coordinator.isShowingCreatePostView) {
        //                SubmitPostCoordinatorView(coordinator: .init(parentCoordinator: coordinator))
        //            }
        .popover(isPresented: $coordinator.isShowingCreateCommunityView) {
            SubmitCommunityCoordinatorView(coordinator: .init(parentCoordinator: coordinator))
        }
    }
    
    @ViewBuilder @MainActor
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .goToCommunity(let community): 
            CommunityCoordinatorView(viewModel: coordinator.communityCoordinatorViewModel(community: community))
        }
    }
}

// MARK: - Preview
#Preview {
    CommunitiesTabCoordinatorView(coordinator: .preview)
}
