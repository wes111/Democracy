//
//  OnboardingCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @StateObject private var viewModel: OnboardingCoordinator
    
    init(viewModel: OnboardingCoordinator) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            CoordinatorView(router: $viewModel.router) {
                LoginView(viewModel: viewModel.loginViewModel())
            } secondaryScreen: { (path: OnboardingPath) in
                createViewFromPath(path)
            }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: OnboardingPath) -> some View {
        switch path {
        case .goToCreateAccount(let viewModel): CreateFieldView(viewModel: viewModel)
        case .goToCreatePassword(let viewModel): CreateFieldView(viewModel: viewModel)
        case .goToCreateEmail(let viewModel): CreateFieldView(viewModel: viewModel)
        case .goToVerifyEmail: EmptyView()
        case .goToVerifyPhone: EmptyView()
        case .goToCreatePhone: EmptyView()
        }
    }
    
}

// MARK: - Preview
#Preview {
    let viewModel = OnboardingCoordinator()
    return OnboardingCoordinatorView(viewModel: viewModel)
}
