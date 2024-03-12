//
//  CreateCommunityCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct SubmitCommunityCoordinatorView: View {
    @State private var coordinator: SubmitCommunityCoordinator
    
    init(coordinator: SubmitCommunityCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            CommunityInputFlowView(viewModel: coordinator.communityInputFlowViewModel)
        } secondaryScreen: { path in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder @MainActor
    func createViewFromPath(_ path: SubmitCommunityPath) -> some View {
        switch path {
        case .goToSuccess(let viewModel):
            SuccessView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    SubmitCommunityCoordinatorView(coordinator: SubmitCommunityCoordinator.preview)
}
