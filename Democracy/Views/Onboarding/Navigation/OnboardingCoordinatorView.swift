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
        CoordinatorView(router: $viewModel.router) {
            CreateFieldView(viewModel: viewModel.createAccountViewModel.createUsernameFieldViewModel)
        } secondaryScreen: { (path: OnboardingPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: OnboardingPath) -> some View {
        switch path {
        case .goToCreatePassword(let viewModel): CreateFieldView(viewModel: viewModel)
        case .goToCreateEmail(let viewModel): CreateFieldView(viewModel: viewModel)
        case .goToVerifyEmail(let viewmodel): CreateFieldView(viewModel: viewmodel)
        case .goToVerifyPhone(let viewmodel): CreateFieldView(viewModel: viewmodel)
        case .goToCreatePhone(let viewModel): CreateFieldView(viewModel: viewModel)
        case .goToCreateAccountSuccess(let viewModel): CreateAccountSuccessView(viewModel: viewModel)
        case .goToAcceptTerms(let viewModel): AcceptTermsView(viewModel: viewModel)
        }
    }
    
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let viewModel = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    return OnboardingCoordinatorView(viewModel: viewModel)
}
