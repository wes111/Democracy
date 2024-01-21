//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabCoordinatorView: View {
    @State private var viewModel: CommunitiesTabCoordinator
    
    init(viewModel: CommunitiesTabCoordinator) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        CoordinatorView(router: viewModel.router) {
            CommunitiesTabMainView(viewModel: viewModel.communitiesTabMainViewModel())
        } secondaryScreen: { (path: CommunitiesTabPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder @MainActor
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .goToCommunity(let community): 
            CommunityCoordinatorView(viewModel: viewModel.communityCoordinatorViewModel(community: community))
        case .goToCreateCommunity:
            CreateCommunityView(viewModel: viewModel.createCommunityViewModel())
        }
    }
}

// MARK: - Preview
#Preview {
    CommunitiesTabCoordinatorView(viewModel: .preview)
}
