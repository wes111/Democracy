//
//  VotingTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

struct VotingTabCoordinator: View {
    
    @StateObject private var viewModel: VotingTabCoordinatorViewModel
    
    init(viewModel: VotingTabCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $viewModel.router.navigationPath) {
            ZStack {
                Color.primaryBackground.ignoresSafeArea()
                VotingTabMainView(viewModel: viewModel.votingTabMainViewModel())
                    .navigationDestination(for: VotingTabPath.self) { path in
                        createViewFromPath(path)
                    }
            }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: VotingTabPath) -> some View {
        switch path {
        case .one: EmptyView()
        }
    }
}

extension VotingTabCoordinator: VotingTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print("tapped nav")
    }
    
}

// MARK: - Preview
struct VotingTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = VotingTabCoordinatorViewModel()
        VotingTabCoordinator(viewModel: viewModel)
    }
}
