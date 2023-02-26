//
//  CommunitiesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

enum CommunitiesTabPath {
    case one
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
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CommunitiesTabPath) -> some View {
        switch path {
        case .one: Text("")
        }
    }
    
    func createCommunitiesTabMainView() -> CommunitiesTabMainView<CommunitiesTabMainViewModel> {
        let viewModel = CommunitiesTabMainViewModel(coordinator: self)
        return CommunitiesTabMainView(viewModel: viewModel)
    }
}

extension CommunitiesTabCoordinator: CommunitiesTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print("tapped nav")
    }
    
}

struct CommunitiesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        CommunitiesTabCoordinator()
    }
}
