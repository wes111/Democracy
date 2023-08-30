//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct CommunitiesTabCoordinatorView: View {
    @StateObject private var viewModel: CommunitiesTabCoordinator
    
    init(viewModel: CommunitiesTabCoordinator) {
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
        case .goToCommunity(let community): CommunityCoordinatorView(viewModel: viewModel.communityCoordinatorViewModel(community: community))
        }
    }
}

// MARK: - Preview
struct CommunitiesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabCoordinatorView(viewModel: .preview)
    }
}
