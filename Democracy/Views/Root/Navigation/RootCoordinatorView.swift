//
//  RootCoordinatorView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/11/23.
//

import SwiftUI

struct RootCoordinatorView: View {
    @State private var viewModel: RootCoordinator
    
    init(viewModel: RootCoordinator) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.loginStatus == .loggedOut {
                LoginView(viewModel: viewModel.loginViewModel())
            } else {
                MainTabView(viewModel: viewModel.mainTabViewModel)
            }
        }
        .popover(isPresented: $viewModel.isShowingOnboardingFlow) {
            CreateAccountCoordinatorView(coordinator: viewModel.createAccountCoordinator())
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
