//
//  OnboardingCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import SwiftUI

@MainActor
struct CreateAccountCoordinatorView: View {
    @State private var coordinator: CreateAccountCoordinator
    
    init(coordinator: CreateAccountCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            AccountInputFlowView(viewModel: coordinator.accountInputFlowViewModel)
        } secondaryScreen: { path in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: CreateAccountPath) -> some View {
        switch path {
        case .goToSuccess(let viewModel):
            SuccessView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    CreateAccountCoordinatorView(coordinator: CreateAccountCoordinator.preview)
}
