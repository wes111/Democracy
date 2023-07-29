//
//  AuthenticationCoordinator.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/20/23.
//

import SwiftUI

enum AuthenticationPath {
    case signIn
    case createAccount
}

class AuthenticationCoordinatorViewModel: ObservableObject {
    let mainTabViewModel: MainTabViewModel
    
    init(mainTabViewModel: MainTabViewModel) {
        self.mainTabViewModel = mainTabViewModel
    }
}

struct AuthenticationCoordinator: View {
    
    @StateObject private var router = Router()
    @StateObject private var viewModel: AuthenticationCoordinatorViewModel
    
    init(viewModel: AuthenticationCoordinatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
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
    }
    
    @ViewBuilder
    func createViewFromPath(_ path: AuthenticationPath) -> some View {
        switch path {
        case .signIn: MainTabView(viewModel: viewModel.mainTabViewModel)
        case .createAccount: MainTabView(viewModel: viewModel.mainTabViewModel)
        }
    }
    
    func createLoginView() -> LoginView<LoginViewModel> {
        let viewModel = LoginViewModel(coordinator: self)
        return LoginView(viewModel: viewModel)
    }
    
}

extension AuthenticationCoordinator: LoginCoordinatorDelegate {
    
    
}
