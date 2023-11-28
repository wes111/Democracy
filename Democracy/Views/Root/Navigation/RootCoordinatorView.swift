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
            if viewModel.loginStatus == .loggedOut {
                LoginView(viewModel: viewModel.loginViewModel())
            } else {
                MainTabView(viewModel: viewModel.mainTabViewModel)
            }
            
        } secondaryScreen: { (path: RootPath) in
            createViewFromPath(path)
        }
        .popover(isPresented: $viewModel.isShowingOnboardingFlow) {
            OnboardingCoordinatorView(coordinator: viewModel.onboardingCoordinator())
        }
        .task {
            await viewModel.startSessionTask()
        }
        // TODO: This should be a fullScreenCover not popover.
        // This temporarily fixes an iOS 17 memory leak.
        // https://developer.apple.com/forums/thread/736239
        
//        .fullScreenCover(isPresented: $viewModel.isShowingOnboardingFlow) {
//            OnboardingCoordinatorView(viewModel: viewModel.onboardingCoordinator())
//        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: RootPath) -> some View {
        switch path {
            // TODO: ...
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
