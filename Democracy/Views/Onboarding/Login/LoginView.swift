//
//  LoginView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 2/22/23.
//

import SwiftUI

enum LoginField {
    case email, password
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
                
                emailField
                passwordField
                loginButton
                forgotPasswordButton
                Spacer()
                createAccountButton
            }
            .padding()
        }
        .onAppear {
            focusedField = .email
        }
        .onTapGesture {
            focusedField = nil
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .cancel())
        }
    }
}

// MARK: - Subviews
extension LoginView {
    
    var emailField: some View {
        TextField("Email", text: $viewModel.email,
                  prompt: Text("Email").foregroundColor(.secondaryBackground), axis: .vertical
        )
        .limitCharacters(
            text: $viewModel.email,
            count: OnboardingInputField.email.maxCharacterCount
        )
        .focused($focusedField, equals: .email)
        .standardTextField()
        .submitLabel(.next)
    }
    
    var passwordField: some View {
        TextField("Password", text: $viewModel.password,
                  prompt: Text("Password").foregroundColor(.secondaryBackground), axis: .vertical
        )
        .limitCharacters(
            text: $viewModel.password,
            count: OnboardingInputField.password.maxCharacterCount
        )
        .focused($focusedField, equals: .password)
        .standardTextField()
        .submitLabel(.go)
    }
    
    var loginButton: some View {
        AsyncButton {
            await viewModel.login()
        } label: {
            Text("Login")
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(!viewModel.isValid)
    }
    
    var forgotPasswordButton: some View {
        Button {
            
        } label: {
            Text("Forgot Password?")
                .font(.callout)
                .foregroundStyle(Color.secondaryText)
        }
    }
    
    var createAccountButton: some View {
        Button {
            /// A bug occurs if the focusedField is not set to nil here because two views
            /// would have active focused fields. This causes bad dismiss animation for the onboarding flow.
            focusedField = nil
            viewModel.createAccount()
        } label: {
            Text("Create Account")
        }
        .buttonStyle(PrimaryButtonStyle())
        
    }
}

// MARK: - Preview
#Preview {
    let coordinator = RootCoordinator()
    let viewModel = LoginViewModel(coordinator: coordinator)
    
    return ZStack {
        Color.primaryBackground
            .ignoresSafeArea()
        LoginView(viewModel: viewModel)
    }
}
