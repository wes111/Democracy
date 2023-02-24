//
//  AuthenticationCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/20/23.
//

import SwiftUI

enum AuthenticationPath {
    case goToMain
    case signIn
    case createAccount
}

struct AuthenticationCoordinator: View, Coordinator {
    @StateObject private var router = Router<AuthenticationPath>()
    
    var id = UUID()
    var childCoordinators: [UUID : Coordinator] = [:]
    var parentCoordinator: Coordinator?
    
    func start() {
        print("Start Authentication coordinator.")
    }
    
    var body: some View {
        NavigationStack(path: $router.paths) {
            createLoginView()
                .navigationDestination(for: AuthenticationPath.self) { path in
                    createViewFromPath(path)
                }
        }
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: AuthenticationPath) -> some View {
        switch path {
        case .signIn: MainTabCoordinator()
        case .createAccount: createLoginView()
        case .goToMain: MainTabCoordinator()
        }
    }
    
    func createLoginView() -> LoginView<LoginViewModel> {
        let viewModel = LoginViewModel(coordinator: self)
        return LoginView(viewModel: viewModel)
    }
    
}

extension AuthenticationCoordinator: LoginCoordinatorDelegate {
    
    func goToMainView() {
        router.push(.goToMain)
    }
    
    
}
