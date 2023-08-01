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
        NavigationStack(path: $viewModel.router.navigationPath) {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                CommunitiesTabMainView(viewModel: viewModel.communitiesTabMainViewModel())
                    .navigationDestination(for: CommunitiesTabPath.self) { path in
                        createViewFromPath(path)
                    }
                    .fullScreenCover(isPresented: $viewModel.isShowingCreateCommunityView) {
                        CreateCommunityView(viewModel: viewModel.createCommunityViewModel())
                    }
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

// MARK: - Preview
struct CommunitiesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabCoordinator(viewModel: .preview)
    }
}
