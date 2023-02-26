//
//  UpdatesTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

enum UpdatesTabPath {
    case one
}

struct UpdatesTabCoordinator: View {
    
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createUpdatesTabMainView()
                .navigationDestination(for: UpdatesTabPath.self) { path in
                    createViewFromPath(path)
                }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: UpdatesTabPath) -> some View {
        switch path {
        case .one: Text("")
        }
    }
    
    func createUpdatesTabMainView() -> UpdatesTabMainView<UpdatesTabMainViewModel> {
        let viewModel = UpdatesTabMainViewModel(coordinator: self)
        return UpdatesTabMainView(viewModel: viewModel)
    }
}

extension UpdatesTabCoordinator: UpdatesTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print("tapped nav")
    }
    
}

struct UpdatesTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        UpdatesTabCoordinator()
    }
}
