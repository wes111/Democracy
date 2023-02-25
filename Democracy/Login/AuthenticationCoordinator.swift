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

struct AuthenticationCoordinator: View {
    
    @StateObject private var router = Router()
    
    func start() {
        print("Start Authentication coordinator.")
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            createLoginView()
                .navigationDestination(for: AuthenticationPath.self) { path in
                    createViewFromPath(path)
                }
        }
        .environmentObject(router)
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: AuthenticationPath) -> some View {
        switch path {
        case .signIn: MainTabView()
        case .createAccount: MainTabView()
        case .goToMain: MainTabView()
        }
    }
    
    func createLoginView() -> LoginView<LoginViewModel> {
        let viewModel = LoginViewModel(coordinator: self)
        return LoginView(viewModel: viewModel)
    }
    
}

extension AuthenticationCoordinator: LoginCoordinatorDelegate {
    
    func goToMainView() {
        router.push(AuthenticationPath.goToMain)
    }
    
    
}
