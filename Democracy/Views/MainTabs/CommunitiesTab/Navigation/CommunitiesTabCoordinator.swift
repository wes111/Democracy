//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabCoordinator: View {
    @StateObject private var viewModel: CommunitiesTabCoordinatorViewModel
    
    init(viewModel: CommunitiesTabCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        CoordinatorView(router: $viewModel.router) {
            CommunitiesTabMainView(viewModel: viewModel.communitiesTabMainViewModel())
        } secondaryScreen: { (path: CommunitiesTabPath) in
            createViewFromPath(path)
        }
        .fullScreenCover(isPresented: $viewModel.isShowingCreateCommunityView) {
            CreateCommunityView(viewModel: viewModel.createCommunityViewModel())
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .goToCommunity(let community): CommunityCoordinator(viewModel: viewModel.communityCoordinatorViewModel(community: community))
        }
    }
}

// MARK: - Preview
struct CommunitiesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabCoordinator(viewModel: .preview)
    }
}
