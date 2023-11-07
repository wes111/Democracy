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

struct SettingsCoordinator: View {
    
    @StateObject private var router = Router()
    
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
