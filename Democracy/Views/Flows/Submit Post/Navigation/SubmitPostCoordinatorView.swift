//
//  SubmitPostCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct SubmitPostCoordinatorView: View {
    @State private var coordinator: SubmitPostCoordinator
    
    init(coordinator: SubmitPostCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            PostInputFlowView(viewModel: coordinator.postInputFlowViewModel)
        } secondaryScreen: { (path: SubmitPostPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder @MainActor
    func createViewFromPath(_ path: SubmitPostPath) -> some View {
        switch path {
        case .goToPostSuccess(let viewModel):
            SuccessView(viewModel: viewModel)
        }
    }
}

// MARK: - Preview
#Preview {
    SubmitPostCoordinatorView(coordinator: SubmitPostCoordinator.preview)
}
