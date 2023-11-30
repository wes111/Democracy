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
    @State private var isKeyboardVisible = false
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.primaryBackground.ignoresSafeArea()
            
            VStack(spacing: isKeyboardVisible ? 20 : 50) {
                
                Image("BMW")
                    .resizable()
                    .scaledToFit()
                    .frame(height: isKeyboardVisible ? 80 : 100)
                
                VStack(spacing: 20) {
                    emailField
                    passwordField
                    loginButton
                    forgotPasswordButton
                    Spacer()
                }
            }
            .padding(.top, isKeyboardVisible ? 20 : 50)
            .padding([.horizontal, .bottom])
            
            VStack {
                Spacer()
                createAccountButton
            }
            .padding([.horizontal, .bottom])
        }
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            focusedField = nil
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .cancel())
        }
        .onReceive(keyboardPublisher) { value in
            withAnimation {
                isKeyboardVisible = value
            }
        }
    }
}

// MARK: - Subviews
extension LoginView {
    
    var emailField: some View {
        TextField("Email", text: $viewModel.email,
                  prompt: Text("Email").foregroundColor(.secondaryBackground)
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
        SecureField(
            "Enter a password",
            text: $viewModel.password,
            prompt: Text("Password").foregroundColor(.secondaryBackground)
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
