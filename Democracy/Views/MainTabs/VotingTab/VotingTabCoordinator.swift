//
//  VotingTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

enum VotingTabPath {
    case one
}

struct VotingTabCoordinator: View {
    
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createVotingTabMainView()
                .navigationDestination(for: VotingTabPath.self) { path in
                    createViewFromPath(path)
                }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: VotingTabPath) -> some View {
        switch path {
        case .one: Text("")
        }
    }
    
    func createVotingTabMainView() -> VotingTabMainView<VotingTabMainViewModel> {
        let viewModel = VotingTabMainViewModel(coordinator: self)
        return VotingTabMainView(viewModel: viewModel)
    }
}

extension VotingTabCoordinator: VotingTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print("tapped nav")
    }
    
}

struct VotingTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        VotingTabCoordinator()
    }
}
