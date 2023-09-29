//
//  LoginView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import SwiftUI

struct LoginView<ViewModel: LoginViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
            TextField("Password", text: $viewModel.password)
            Button {
                Task {
                    await viewModel.login()
                }
            } label: {
                Text("Login")
            }
            Button {
                viewModel.createAccount()
            } label: {
                Text("Create a static accountl")
            }
            Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
            }
        }
    }
}

//MARK: - Preview
#Preview {
    let mainTabViewModel = MainTabViewModel()
    let authenticationCoordinatorViewModel = AuthenticationCoordinatorViewModel(mainTabViewModel: mainTabViewModel)
    let coordinator = AuthenticationCoordinator(viewModel: authenticationCoordinatorViewModel)
    let viewModel = LoginViewModel(coordinator: coordinator)
    return LoginView(viewModel: viewModel)
}
