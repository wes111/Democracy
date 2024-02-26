//
//  OnboardingCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 9/30/23.
//

import SwiftUI

struct OnboardingCoordinatorView: View {
    @State private var coordinator: OnboardingCoordinator
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        CoordinatorView(router: coordinator.router) {
            UsernameOnboardingInputView(viewModel: coordinator.createUsernameFieldViewModel)
        } secondaryScreen: { (path: OnboardingPath) in
            createViewFromPath(path)
        }
    }
    
    @ViewBuilder @MainActor
    func createViewFromPath(_ path: OnboardingPath) -> some View {
        switch path {
        case .goToCreatePassword(let viewModel): PasswordOnboardingInputView(viewModel: viewModel)
        case .goToCreateEmail(let viewModel): EmailOnboardingInputView(viewModel: viewModel)
        case .goToCreatePhone(let viewModel): PhoneOnboardingInputView(viewModel: viewModel)
        case .goToCreateAccountSuccess(let viewModel): SuccessView(viewModel: viewModel)
        case .goToAcceptTerms(let viewModel): AcceptTermsView(viewModel: viewModel)
        }
    }
    
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let viewModel = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    return OnboardingCoordinatorView(coordinator: viewModel)
}
