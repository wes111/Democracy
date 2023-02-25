//
//  SettingsCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/24/23.
//

import SwiftUI

enum SettingsPath: Hashable {
    case b
}


struct SettingsCoordinator: View {
    
    @EnvironmentObject private var router: Router
    
    var body: some View {
        createRootView()
            .navigationDestination(for: SettingsPath.self) { path in
                createViewFromPath(path)
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: SettingsPath) -> some View {
        switch path {
        case .b: Text("To Do.")
        }
    }
    
    private func createRootView() -> SettingsView<SettingsViewModel> {
        let viewModel = SettingsViewModel(coordinator: self)
        return SettingsView(viewModel: viewModel)
    }
}

extension SettingsCoordinator: SettingsCoordinatorDelegate {

    
    
}
