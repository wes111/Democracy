//
//  SettingsCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/24/23.
//

import SwiftUI

enum SettingsPath: Hashable {
    case todo
}

@MainActor
struct SettingsCoordinator: View {
    
    @State private var router = Router()
    
    var body: some View {
        createRootView()
            .navigationDestination(for: SettingsPath.self) { path in
                createViewFromPath(path)
            }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: SettingsPath) -> some View {
        switch path {
        case .todo: Text("To Do.")
        }
    }
    
    @MainActor
    private func createRootView() -> SettingsView<SettingsViewModel> {
        let viewModel = SettingsViewModel()
        return SettingsView(viewModel: viewModel)
    }
}

// extension SettingsCoordinator: SettingsCoordinatorDelegate {
//
//    
//    
// }
