//
//  HistoryTabCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/25/23.
//

import SwiftUI

enum HistoryTabPath {
    case one
}

struct HistoryTabCoordinator: View {
    
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createHistoryTabMainView()
                .navigationDestination(for: HistoryTabPath.self) { path in
                    createViewFromPath(path)
                }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: HistoryTabPath) -> some View {
        switch path {
        case .one: Text("")
        }
    }
    
    func createHistoryTabMainView() -> HistoryTabMainView<HistoryTabMainViewModel> {
        let viewModel = HistoryTabMainViewModel(coordinator: self)
        return HistoryTabMainView(viewModel: viewModel)
    }
}

extension HistoryTabCoordinator: HistoryTabMainCoordinatorDelegate {
    
    func tappedNav() {
        print("tapped nav")
    }
    
}

struct HistoryTabCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTabCoordinator()
    }
}
