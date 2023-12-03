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
    @State private var keyboardVisibilityChangedTask: Task<Void, Error>?
    
    init(viewModel: LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Color.primaryBackground.ignoresSafeArea()
                VStack(spacing: isKeyboardVisible ? 20 : 50) {
                    logoView
                    VStack(spacing: 20) {
                        emailField
                        passwordField
                        loginButton
                        forgotPasswordButton
                        Spacer()
                    }
                }
                .frame(alignment: .top)
                .padding(.top, isKeyboardVisible ? 20 : 50)
                .padding([.horizontal, .bottom])
                
                VStack {
                    Spacer()
                    if viewModel.isShowingProgress {
                        progressView
                    }
                    Spacer()
                    createAccountButton
                }
                .frame(height: geo.size.height / 2, alignment: .bottom)
                .padding([.horizontal, .bottom])
            }
            .geometryGroup() // Causes sizes controlled by 'isKeyboardVisible' to update simultaneously.
            .ignoresSafeArea(.keyboard)
        }
        .onTapGesture {
            focusedField = nil
        }
        .alert(item: $viewModel.alert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: .cancel())
        }
        .onReceive(keyboardPublisher) { isVisible in
            startKeyboardVisibilityDidChangeTask(isVisible: isVisible)
        }
    }
}

// MARK: - Subviews
extension LoginView {
    
    var progressView: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.secondaryText)
    }
    
    var logoView: some View {
        Image("BMW")
            .resizable()
            .scaledToFit()
            .frame(height: isKeyboardVisible ? 80 : 100)
    }
    
    var emailField: some View {
        TextField("Email", text: $viewModel.email,
                  prompt: Text("Email").foregroundColor(.secondaryBackground)
        )
        .limitCharacters(
            text: $viewModel.email,
            count: OnboardingInputField.email.maxCharacterCount
        )
        .standardTextField()
        .contentShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        .onTapGesture {
            focusedField = .email
        }
        .focused($focusedField, equals: .email)
        .submitLabel(.continue)
        .onSubmit {
            focusedField = .password
        }
    }
    
    var passwordField: some View {
        CustomSecureField(secureText: $viewModel.password, loginField: $focusedField)
            .focused($focusedField, equals: .password)
            .submitLabel(.go)
            .onSubmit {
                performAsnycTask(
                    action: viewModel.login,
                    isShowingProgress: $viewModel.isShowingProgress
                )
            }
    }
    
    var loginButton: some View {
        AsyncButton(
            action: {
                focusedField = nil
                await viewModel.login()
            },
            label: {
                Text("Login")
            },
            showProgressView: $viewModel.isShowingProgress
        )
        .buttonStyle(PrimaryButtonStyle())
        .disabled(viewModel.isShowingProgress)
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
            /// could have active focused fields. This causes bad dismiss animation for the onboarding flow.
            focusedField = nil
            viewModel.createAccount()
        } label: {
            Text("Create Account")
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(viewModel.isShowingProgress)
    }
}

// MARK: - Helper Methods
private extension LoginView {
    // This method helps smooth an iOS keyboard dismiss bug when updating the @FocusState.
    // swiftlint:disable:next line_length
    // https://stackoverflow.com/questions/73112180/textfield-is-dismissed-when-setting-a-new-textfield-focus-in-ios-16
    func startKeyboardVisibilityDidChangeTask(isVisible: Bool) {
        keyboardVisibilityChangedTask?.cancel()
        keyboardVisibilityChangedTask = Task {
            try await Task.sleep(nanoseconds: 50_000_000)
            withAnimation {
                isKeyboardVisible = isVisible
            }
        }
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
