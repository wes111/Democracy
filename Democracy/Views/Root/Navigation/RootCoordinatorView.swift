//
//  RootCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/11/23.
//

import SwiftUI

struct RootCoordinatorView: View {
    @StateObject private var viewModel: RootCoordinator
    
    init(viewModel: RootCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        CoordinatorView(router: $viewModel.router) {
            LoginView(viewModel: viewModel.loginViewModel())
        } secondaryScreen: { (path: RootPath) in
            createViewFromPath(path)
        }
        .fullScreenCover(isPresented: $viewModel.isShowingOnboardingFlow) {
            OnboardingCoordinatorView(viewModel: viewModel.onboardingCoordinator())
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: RootPath) -> some View {
        switch path {
            //TODO: ...
        default:
            EmptyView()
        }
    }
}

// MARK: - Preview
#Preview {
    let coordinator = RootCoordinator()
    return RootCoordinatorView(viewModel: coordinator)
}
