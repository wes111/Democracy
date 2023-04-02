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
            TextField("Username", text: $viewModel.userName)
            TextField("Password", text: $viewModel.password)
            Button {
                viewModel.login()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let coordinator = AuthenticationCoordinator()
        let viewModel = LoginViewModel(coordinator: coordinator)
        LoginView(viewModel: viewModel)
    }
}
