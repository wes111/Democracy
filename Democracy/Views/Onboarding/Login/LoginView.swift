//
//  LoginView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import SwiftUI

enum LoginField {
    case username, password
}

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @FocusState private var focusedField: LoginField?
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image("BMW")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .frame(height: 175)
                
                usernameField
                passwordField
                loginButton
                forgotPasswordButton
                Spacer()
                createAccountButton
            }
            .padding()
        }
        .onAppear {
            focusedField = .username
        }
    }
}

//MARK: - Subviews
extension LoginView {
    
    var usernameField: some View {
        TextField("Username", text: $viewModel.username,
                  prompt: Text("Username").foregroundColor(.secondaryBackground), axis: .vertical
        )
        //.limitCharacters(text: $viewModel.username, count: UsernameValidationError.maxCharacterCount)
        .focused($focusedField, equals: .username)
        .standardTextField()
        .submitLabel(.next)
    }
    
    var passwordField: some View {
        TextField("Password", text: $viewModel.password,
                  prompt: Text("Password").foregroundColor(.secondaryBackground), axis: .vertical
        )
        //.limitCharacters(text: $viewModel.password, count: PasswordValidationError.maxCharacterCount)
        .focused($focusedField, equals: .password)
        .standardTextField()
        .submitLabel(.go)
    }
    
    var loginButton: some View {
        Button() {
            
        } label: {
            Text("Login")
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.isValid)
    }
    
    var forgotPasswordButton: some View {
        Button() {
            
        } label: {
            Text("Forgot Password?")
                .font(.callout)
                .foregroundStyle(Color.secondaryText)
        }
    }
    
    var createAccountButton: some View {
        Button() {
            viewModel.createAccount()
        } label: {
            Text("Create Account")
        }
        .buttonStyle(PrimaryButtonStyle())
        
    }
}

//MARK: - Preview
#Preview {
    let coordinator = OnboardingCoordinator()
    let viewModel = LoginViewModel(coordinator: coordinator)
    
    return ZStack {
        Color.primaryBackground
            .ignoresSafeArea()
        LoginView(viewModel: viewModel)
    }
}
